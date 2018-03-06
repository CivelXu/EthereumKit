//
//  EIP155SignerTests.swift
//  EthereumKitTests
//
//  Created by yuzushioh on 2018/03/05.
//  Copyright © 2018 yuzushioh. All rights reserved.
//

import XCTest
import SMP
@testable import EthereumKit

class EIP155SignerTests: XCTestCase {
    func testEIP155SigningOnTestnet() {
        let signer = EIP155Signer(chainID: 3)
        
        let signTransaction1 = SignTransaction(
            value: BInt("10000000000000000")!,
            to: Address(string: "0x91c79f31De5208fadCbF83f0a7B0A9b6d8aBA90F"),
            gasPrice: BInt(99000000000),
            gasLimit: BInt(21000),
            data: Data(),
            nonce: 2
        )
        
        XCTAssertEqual(
            signer.hash(signTransaction: signTransaction1).toHexString(),
            "84df8756f832aa25f79fdeac98ae9adf83b1da0119dd3555807f890f09c3e1a7"
        )
        
        let signTransaction2 = SignTransaction(
            value: BInt("10000000000000000")!,
            to: Address(string: "0x88b44BC83add758A3642130619D61682282850Df"),
            gasPrice: BInt(99000000000),
            gasLimit: BInt(21000),
            data: Data(),
            nonce: 4
        )
        
        XCTAssertEqual(
            signer.hash(signTransaction: signTransaction2).toHexString(),
            "18f93470671a0db633e4346dfa5ecdc2568e2befdbf815ac205d9eef06a91350"
        )
        
        let signTransaction3 = SignTransaction(
            value: BInt("10000000000000000")!,
            to: Address(string: "0x72AAb5461F9bE958E1c375285CC2aA7De89D02A1"),
            gasPrice: BInt(99000000000),
            gasLimit: BInt(21000),
            data: Data(),
            nonce: 25
        )
        
        XCTAssertEqual(
            signer.hash(signTransaction: signTransaction3).toHexString(),
            "0af0867d4acb71dd0bd590b86aef78d7ccfdcdcf16e881e9f426e432a1603eaf"
        )
    }
    
    func testEIP155SigningOnMainnet() {
        let signer = EIP155Signer(chainID: 1)
        
        let signTransaction1 = SignTransaction(
            value: BInt("10000000000000000")!,
            to: Address(string: "0x91c79f31De5208fadCbF83f0a7B0A9b6d8aBA90F"),
            gasPrice: BInt(99000000000),
            gasLimit: BInt(21000),
            data: Data(),
            nonce: 2
        )
        
        XCTAssertEqual(
            signer.hash(signTransaction: signTransaction1).toHexString(),
            "de6ed032e8f09adb557f6a0ebc16ed52d6a75e0644a77a236aa1cfffa7746e9a"
        )
        
        let signTransaction2 = SignTransaction(
            value: BInt("10000000000000000")!,
            to: Address(string: "0x88b44BC83add758A3642130619D61682282850Df"),
            gasPrice: BInt(99000000000),
            gasLimit: BInt(200000),
            data: Data(),
            nonce: 4
        )
        
        XCTAssertEqual(
            signer.hash(signTransaction: signTransaction2).toHexString(),
            "b148272b2a985365e08abb17a85ca5e171169978f3b55e6852a035f83b9f3aa5"
        )
        
        let signTransaction3 = SignTransaction(
            value: BInt("20000000000000000")!,
            to: Address(string: "0x72AAb5461F9bE958E1c375285CC2aA7De89D02A1"),
            gasPrice: BInt(99000000000),
            gasLimit: BInt(21000),
            data: Data(),
            nonce: 25
        )
        
        XCTAssertEqual(
            signer.hash(signTransaction: signTransaction3).toHexString(),
            "280e29f030cfa256b4298a2b834a4add92b37f159b3cce1110e1ff9f7514f9fe"
        )
    }
    
    func testGeneratingRSVOnTestnet() {
        let signiture = Data(hex: "28ef61340bd939bc2195fe537567866003e1a15d3c71ff63e1590620aa63627667cbe9d8997f761aecb703304b3800ccf555c9f3dc64214b297fb1966a3b6d8300")
        let (r, s, v) = EIP155Signer(chainID: 3).calculateRSV(signiture: signiture)
        XCTAssertEqual(r, BInt("18515461264373351373200002665853028612451056578545711640558177340181847433846")!.serialize())
        XCTAssertEqual(s, BInt("46948507304638947509940763649030358759909902576025900602547168820602576006531")!.serialize())
        XCTAssertEqual(v, BInt(41).serialize())
    }
    
    func testGeneratingRSVOnMainnet() {
        let signiture = Data(hex: "28ef61340bd939bc2195fe537567866003e1a15d3c71ff63e1590620aa63627667cbe9d8997f761aecb703304b3800ccf555c9f3dc64214b297fb1966a3b6d8300")
        let (r, s, v) = EIP155Signer(chainID: 1).calculateRSV(signiture: signiture)
        XCTAssertEqual(r, BInt("18515461264373351373200002665853028612451056578545711640558177340181847433846")!.serialize())
        XCTAssertEqual(s, BInt("46948507304638947509940763649030358759909902576025900602547168820602576006531")!.serialize())
        XCTAssertEqual(v, BInt(37).serialize())
    }
}