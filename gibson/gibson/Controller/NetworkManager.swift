//
//  NetworkManager.swift
//  gibson
//
//  Created by Michael Critz on 9/27/14.
//  Copyright (c) 2014 gibson. All rights reserved.
//

import Foundation
import MultipeerConnectivity

enum NetMessage: Int {
	case NetMessageHandshake=1
	case NetMessageNegotiate,
			NetMessageNegotiateConfirm,
			NetMessageAttack,
			NetMessageDefend,
			NetMessageSteal,
			NetMessageWin,
			NetMessageDisconnect
}


//class NetworkManager : NSObject {
class NetworkManager :NSObject, MCNearbyServiceBrowserDelegate, MCNearbyServiceAdvertiserDelegate, MCSessionDelegate {

	var nearbyBrowser :MCNearbyServiceBrowser
	var nearbyAdvertiser :MCNearbyServiceAdvertiser
	var session :MCSession
	var peerId :NSString?
	var playerIndexTimestamp :NSDate?
	
	var isBrowsing = false
	
	
	// BrowserDelegate Protocol
	func browser(browser: MCNearbyServiceBrowser!, lostPeer peerID: MCPeerID!) {
		println("Lost peer")
	}
	
	func browser(browser: MCNearbyServiceBrowser!, foundPeer peerID: MCPeerID!, withDiscoveryInfo info: [NSObject : AnyObject]!) {
		println("FOUND PEER!! WhatWhat!?")
	}
	
	// AdvertiserDelegate Protocol
	func advertiser(advertiser: MCNearbyServiceAdvertiser!, didNotStartAdvertisingPeer error: NSError!) {
		println("Did not start advertising peer!")
	}
	
	func advertiser(advertiser: MCNearbyServiceAdvertiser!, didReceiveInvitationFromPeer peerID: MCPeerID!, withContext context: NSData!, invitationHandler: ((Bool, MCSession!) -> Void)!) {
		var notice = NSNotification(name: "didRecieveInvite", object: nil)
		var noticeCenter = NSNotificationCenter()
		noticeCenter.postNotification(notice)
		println("didReceiveInvitationFromPeer")
	}
	
	// SessionDelegate
	func session(session: MCSession!, didFinishReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, atURL localURL: NSURL!, withError error: NSError!) {
		println("Session Delegate 1")
	}
	func session(session: MCSession!, didReceiveCertificate certificate: [AnyObject]!, fromPeer peerID: MCPeerID!, certificateHandler: ((Bool) -> Void)!) {
		println("Session Delegate 2")
	}
	func session(session: MCSession!, didReceiveData data: NSData!, fromPeer peerID: MCPeerID!) {
		println("Session Delegate 3")
	}
	func session(session: MCSession!, didReceiveStream stream: NSInputStream!, withName streamName: String!, fromPeer peerID: MCPeerID!) {
		println("Session Delegate 4")
	}
	func session(session: MCSession!, didStartReceivingResourceWithName resourceName: String!, fromPeer peerID: MCPeerID!, withProgress progress: NSProgress!) {
		println("Session Delegate 5")
	}
	func session(session: MCSession!, peer peerID: MCPeerID!, didChangeState state: MCSessionState) {
		println("Session Delegate 6")
	}
	
	// Logics
	func hasPeer() -> Bool {
		return self.peerId != nil
	}
	
	override init() {

		// set MCID to user device name
		var deviceId = UIDevice.currentDevice().name
		var myId = MCPeerID(displayName:deviceId)
		
		// setup browser
		nearbyBrowser = MCNearbyServiceBrowser(peer: myId, serviceType: "hack")
		nearbyBrowser.startBrowsingForPeers()
		self.isBrowsing = true
		
		// setup advertiser
		nearbyAdvertiser = MCNearbyServiceAdvertiser(peer: myId, discoveryInfo: nil, serviceType: "hack")
		nearbyAdvertiser.startAdvertisingPeer()
		
		// create a session
		session = MCSession(peer: myId)
		
		super.init()
		nearbyBrowser.delegate = self
		nearbyAdvertiser.delegate = self
		session.delegate = self
		
		let someDict :NSDictionary = ["key":"value"]
		sendDictionaryToPeers(someDict)

	}
	
	func sendDictionaryToPeers(dict: NSDictionary) {
		var error: NSError?
		var encodedData: NSData = NSKeyedArchiver.archivedDataWithRootObject(dict)
		var didSend: Bool = session.sendData(encodedData, toPeers: session.connectedPeers, withMode: MCSessionSendDataMode.Reliable, error: &error)
		
		println("didSend: " + didSend.description)
		println(dict)
		if let error = error {
			println("Failed to send data to peers. :'(")
		}
	}

}