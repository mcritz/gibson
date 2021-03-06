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
class NetworkManager :NSObject, MCBrowserViewControllerDelegate, MCSessionDelegate {

	var browser :MCBrowserViewController!
	var assistant :MCAdvertiserAssistant!
	var session :MCSession!
	var myID :MCPeerID!
	
	var playerIndexTimestamp :NSDate?
	
	var isBrowsing = false
	
	
	// BrowserDelegate Protocol
	func browser(browser: MCNearbyServiceBrowser!, lostPeer peerID: MCPeerID!) {
		println("Lost peer")
	}
	
	func browser(browser: MCNearbyServiceBrowser!, foundPeer peerID: MCPeerID!, withDiscoveryInfo info: [NSObject : AnyObject]!) {
		println("FOUND PEER!! WhatWhat!?")
		println(session.description)
		browser.invitePeer(peerID, toSession: session, withContext: NSData(), timeout: 0.0)
	}
	
	// AdvertiserDelegate Protocol
	func advertiser(advertiser: MCNearbyServiceAdvertiser!, didNotStartAdvertisingPeer error: NSError!) {
		println("Did not start advertising peer!")
	}
	
	func advertiser(advertiser: MCNearbyServiceAdvertiser!, didReceiveInvitationFromPeer peerID: MCPeerID!, withContext context: NSData!, invitationHandler: ((Bool, MCSession!) -> Void)!) {
		var notice = NSNotification(name: "didRecieveInvite", object: nil)
		NSNotificationCenter.defaultCenter().postNotification(notice)
		
		invitationHandler
		
		println("didReceiveInvitationFromPeer")
	}
	
	// BrowserViewControllerDelegate
	func browser(browser: MCNearbyServiceBrowser!, didNotStartBrowsingForPeers error: NSError!) {
		println("did not start browsing")
	}
	
	func browserViewController(browserViewController: MCBrowserViewController!, shouldPresentNearbyPeer peerID: MCPeerID!, withDiscoveryInfo info: [NSObject : AnyObject]!) -> Bool {
		println("should present nearbypeer")
		return true
	}
	
	func browserViewControllerDidFinish(browserViewController: MCBrowserViewController!) {
		println("browser did finish")
	}
	
	func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController!) {
		println("browser cancelled")
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
		if (state == MCSessionState.Connected) {
			var handshake :NSDictionary = [
				"command" : NetMessage.NetMessageHandshake.rawValue,
				"peerName" : UIDevice.currentDevice().name
			]
			sendDictionaryToPeers(handshake)
		} else if (state == MCSessionState.NotConnected) {
			NSLog("No connection")
			disconnect()
		}
	}
	// Logics
	func hasPeer() -> Bool {
		return self.myID != nil
	}
	
	func disconnect() {
		let dict :NSDictionary = [
			"command" : NetMessage.NetMessageDisconnect.rawValue,
			"status" : "disconnected"
		]
		let disconnectNotice = NSNotification(name: "dataRecieved", object: dict)
		NSNotificationCenter.defaultCenter().postNotification(disconnectNotice)
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
	
	override init() {
		let serviceType = "hackFight"
		
		// set MCID to user device name
		var deviceId = UIDevice.currentDevice().name ?? "DEFAULT_BROWSER"
		self.myID = MCPeerID(displayName: deviceId)
		
		// create a session
		session = MCSession(peer: myID)

		// setup browser
		self.browser = MCBrowserViewController(serviceType: serviceType, session: session)
		self.isBrowsing = true
		
		// assistant
		self.assistant = MCAdvertiserAssistant(serviceType: serviceType, discoveryInfo: nil, session: session)
		
		
		super.init()
		self.browser.delegate = self
		session.delegate = self
		self.assistant.start()
		println("NetworkManager init")
	}

}