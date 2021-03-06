//
//  UInt256TestArithmetic.swift
//  UInt256
//
//  Created by Sjors Provoost on 06-07-14.
//

import XCTest
import UInt256

class UInt256TestArithmetic: XCTestCase {

    #if DEBUG
    let million = 1000
    #else
    let million = 1_000_000
    #endif

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testEquality() {
        let a = UInt256(decimalStringValue: "115792089237316195423570985008687907852589419931798687112530834793049593217026")
        let b = UInt256(decimalStringValue: "115792089237316195423570985008687907852589419932798687112530834793049593217026")
        
        
        var res = false
        
        self.measureBlock() {
            for _ in 1...self.million {
                res =  a != b
            }
            
        }
        
        XCTAssertTrue(res, "");
    }
    
    func testCompare() {
        let a = UInt256(decimalStringValue: "115792089237316195423570985008687907852589419931798687112530834793049593217026")
        let b = UInt256(decimalStringValue: "115792089237316195423570985008687907852589419932799687112530834793049593217026")
        
        
        var res = false
        
        self.measureBlock() {
            for _ in 1...self.million {
                res =  b > a
            }
            
        }
        
        XCTAssertTrue(res, "");
    }
    
    func testAdd() {
        let a = UInt256(decimalStringValue: "14")
        let b = UInt256(decimalStringValue: "26")
        let c = UInt256(decimalStringValue: "40")
        
        XCTAssertEqual(a + b, c, "a + b = c");
        
    }
    
    func testAddHex() {
        let a = UInt256(hexStringValue: "14")
        let b = UInt256(hexStringValue: "26")
        let c = UInt256(hexStringValue: "3A")
        
        XCTAssertEqual(a + b, c, "a + b = c");
        
    }
    
    
    func testAddBig() {
        let a = UInt256(decimalStringValue: "14000000123400000001")
        let b = UInt256(decimalStringValue: "26000000123400000001")
        let c = UInt256(decimalStringValue: "40000000246800000002")
        
        XCTAssertEqual(a + b, c, "\(a) + \(b) = \( c )");
    }
    
    func testAddBigHex() {
        let a   = UInt256(hexStringValue:  "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF") // 128 bit
        let b   = UInt256(hexStringValue:  "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE") // 128 bit
        let sum = UInt256(hexStringValue: "1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD") // 129 bit
        
        var result: UInt256 = 0
        
        self.measureBlock() {
            for _ in 1...self.million {
                result = a + b
            }
            
        }
        
        XCTAssertEqual(result, sum, result.toHexString);

        
    }
    
    func testSubtract() {
        let a = UInt256(decimalStringValue: "40")
        let b = UInt256(decimalStringValue: "26")
        let c = UInt256(decimalStringValue: "14")
        
        XCTAssertEqual(a - b, c, "a - b = c");
        
    }
    
    func testSubtractHex() {
        let a = UInt256(hexStringValue: "3A")
        let b = UInt256(hexStringValue: "26")
        let c = UInt256(hexStringValue: "14")
        
        XCTAssertEqual(a - b, c, "a - b = c");
        
    }
    
    func testSubtractBig() {
        let a = UInt256(hexStringValue: "40000000000000000000")
        let b = UInt256(hexStringValue: "26000000000000000001")
        let c = UInt256(hexStringValue: "19FFFFFFFFFFFFFFFFFF")
        
        XCTAssertEqual(a - b, c, "a - b = c");
        
    }
    
    func testSubtractBigger() {
        let a = UInt256(decimalStringValue: "489155902448849041265494486330585906971")
        let b = UInt256(decimalStringValue: "340282366920938463463374607431768211297")
        
        let c = UInt256(decimalStringValue: "148873535527910577802119878898817695674")
        
        var res: UInt256 = 0
        
        self.measureBlock() {
            for _ in 1...self.million / 100 {
                res = a - b
            }
        }
        
        XCTAssertEqual(a - b, c, "a - b = c");

    }
    


    
    

    
    func testSquare131070() {
        let a = UInt256(decimalStringValue: "131070")
        let b = UInt256(decimalStringValue: "131070")
        let product = UInt256(decimalStringValue: "17179344900") // 33 bits
        
        let res: UInt256 =  a * b
        
        XCTAssertEqual(res, product, res.description);
        
    }
    
    func testMultiplyShouldNotMutate() {
        let a = UInt256(decimalStringValue: "32")
        let b = UInt256(decimalStringValue: "2")
        let c = UInt256(decimalStringValue: "64")
        
        var res: UInt256 =  a * b
        res = a * b
        
        XCTAssertEqual(res, c, "Res mutated to \( res)");
        
        
    }
    
    
    func testSquareUInt60Max() {
        let a = UInt256(hexStringValue: "FFFFFFF")
        let c = UInt256(hexStringValue: "FFFFFFE0000001")
        
        let res: UInt256 = a * a
        
        XCTAssertEqual(res, c, res.description);
        
    }
    
    func testMultiplyUInt64MaxWith3() {
        let a = UInt256(hexStringValue: "FFFFFFFFFFFFFFFF") // UInt64.max
        let b = UInt256(hexStringValue: "3") // 0b0011
        
        let c = UInt256(hexStringValue: "2FFFFFFFFFFFFFFFD")
        
        let res: UInt256 = a * b
        
        XCTAssertEqual(res, c, res.description);
        
    }

    func testSquareUInt64Max() {
        let a = UInt256(hexStringValue: "FFFFFFFFFFFFFFFF") // UInt64.max
        let c = UInt256(hexStringValue: "FFFFFFFFFFFFFFFE0000000000000001")
        
        let res: UInt256 = a * a
        
        XCTAssertEqual(res, c, res.description);
        
    }

//    func testMultiplyOverflow() {
//        let a = UInt256(hexStringValue: "8888888888888888888888888888888888888888888888888888888888888888")
//        let b = UInt256(hexStringValue: "0000000000000000000000000000000000000000000000000000000000000002")
//        let c = UInt256(hexStringValue: "1111111111111111111111111111111111111111111111111111111111111110")
//        
//        // Should crash: 
//        let res = a * b
//        
//        // Unsafe multiply is not supported, so this will crash as well:
//        let res = a &* b
//        
//        XCTAssertTrue(res == c, "");
//    }

    func testMultiplyToTuple() {
        
        let a = UInt256(hexStringValue: "8888888888888888888888888888888888888888888888888888888888888888")
        let b = UInt256(hexStringValue: "0000000000000000000000000000000000000000000000000000000000000002")
        let c = (UInt256(hexStringValue: "0000000000000000000000000000000000000000000000000000000000000001"), UInt256(hexStringValue: "1111111111111111111111111111111111111111111111111111111111111110"))
        
        // Should crash: let res = a * b
        
        let (resLeft, resRight) = a * b
        let (cLeft, cRight) = c
        
        
        XCTAssertTrue(resLeft == cLeft && resRight == cRight, "( \(resLeft), \(resRight) )");
    }

    func testModuloFromTuple() {
        let tuple = (UInt256(hexStringValue: "33F23902074835C68CC1630F5EA81161C3720765CC78C137D6434422659760CC"),UInt256(hexStringValue: "493EF0F253A03B4AB649EA632C432258F7886805422976F65A3E63DE32D809D8"))
        
        let p = UInt256(hexStringValue: "FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFFC2F")
        
        let modulo = UInt256(hexStringValue: "8FF2B776AAF6D91942FD096D2F1F7FD9AA2F64BE71462131AA7F067E28FEF8AC")
        
        let result = tuple % p
        
        XCTAssertEqual(result, modulo, result.toHexString)
    }


    func testDivide() {
        let a = UInt256(decimalStringValue: "640")
        let b = UInt256(decimalStringValue: "4")
        let c = UInt256(decimalStringValue: "160")
        
        let res =  a / b
        
        XCTAssertEqual(res, c, "\(a) / \(b) = \( res ) != \( c )");
        
    }

    func testModulo() {
        let a = UInt256(decimalStringValue: "23")
        let b = UInt256(decimalStringValue: "5")
        let c = UInt256(decimalStringValue: "3")
        
        let res =  a % b
        
        XCTAssertEqual(res, c,res.description);
        
    }
    
    
    func testModuloLarger() {
        let a = UInt256(decimalStringValue: "25000000000000000000000000000000000000000000000000000000000000000000000004")
        let b = UInt256(decimalStringValue: "5000000000000000000000000000000000000")
        let c = UInt256(decimalStringValue: "4")
        
        let res =  a % b
        
        XCTAssertEqual(res, c, "\(a) % \(b) = \( res ) != \( c )");
        
    }

    func testModuloMoreComplex() {
        let a = UInt256(decimalStringValue: "2145932040592314323128185")
        let b = UInt256(decimalStringValue: "897983433434")
        let c = UInt256(decimalStringValue: "3")
        
        let res =  a % b
        
        XCTAssertEqual(res, c, "\(a) % \(b) = \( res ) != \( c )");
        
    }
    
    func testDivideBig() {
        let a = UInt256(decimalStringValue: "115792089237316195423570985008687907852589419931798687112530834793049593217025")
        let b = UInt256(decimalStringValue: "340282366920938463463374607431768211455")
        let c = UInt256(decimalStringValue: "340282366920938463463374607431768211455")
        
        var res: UInt256 = 0
        
        self.measureBlock() {
            for _ in 1...self.million / 100 {
                res =  a / b
            }
        }
        
        XCTAssertEqual(res, c, "\(a) / \(b) = \( res ) != \( c )");
        
    }

    func testModuloLargest128bitPrime() {
        // According to http://primes.utm.edu/lists/2small/100bit.html, 2^128-159 is prime
        // According to Ruby that's: 340282366920938463463374607431768211297
        
        
        var a = UInt256(decimalStringValue: "340282366920938463463374607431768211298")
        var b = UInt256(decimalStringValue: "340282366920938463463374607431768211297")
        var c = UInt256(decimalStringValue: "1")
        
        var res =  a % b
        
        XCTAssertEqual(res, c, "\(a) % \(b) = \( res ) != \( c )");
        
        // (2**128 - 159) * 55 + 5 (according to Ruby)
        a = UInt256(decimalStringValue: "18715530180651615490485603408747251621340")
        b = UInt256(decimalStringValue: "340282366920938463463374607431768211297")
        c = UInt256(decimalStringValue: "5")
       
        res =  a % b
        
        // Fails:
        XCTAssertEqual(res, c, "\(a) % \(b) = \( res ) != \( c )");
        
        
    }

    func testModuloBig() {
        let a = UInt256(decimalStringValue: "115792089237316195423570985008687907852589419931798687112530834793049593217026")
        let b = UInt256(decimalStringValue: "340282366920938463463374607431768211455")

        
        var res: UInt256 = 0
        
        self.measureBlock() {
            for _ in 1...self.million / 100 {
                res =  a % b
            }
            
        }
        
        let c = UInt256(decimalStringValue: "1")


        XCTAssertEqual(res, c, "");

        
    }

    func testModularMultiplicativeInverse() {
        let a = UInt256(hexStringValue: "2b80697edf28a916d822b9b89a8f770fb70d49f48b5c184f2f47f652db960baa")
        let m = UInt256(hexStringValue:  "fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f")
        
        let aInverse = UInt256(hexStringValue: "7ae012558f0053523a39cfe291c0fea21d2c23f41a3805c1c487c93aa83fdac1")
        
        var res: UInt256 = 0
        
        self.measureBlock() {
            for i: UInt16 in UInt16(0)...UInt16(self.million / 1_000_00) {
        
               res = a.modInverse(m)
            }
        }
        
        XCTAssertEqual(res, aInverse, res.toHexString);
        
    }
    
    func testModularMultiplicativeInverseSmall() {
        let p: UInt256 = 11
        let a: UInt256 =  5
        
        let inverse: UInt256 = 9 // 9  * 5 = 45 -> 45 % 9 = 1
        
        let result = a.modInverse(p)
        
        XCTAssertEqual(inverse, result, result.toDecimalString);
    }
    
    
    func testMultiplyToMax32Bit() {
        let a = UInt256(decimalStringValue: "65535")
        let c = UInt256(decimalStringValue: "4294836225")
        
        var res:UInt256 = 0
        
        self.measureBlock() {
            
            for _ in 1...self.million {
                
                res = a * a  // 0.9999...% of 32 bit max
            }
            
        }
        
        XCTAssertEqual(res, c, res.description);
        
        
    }
    
    func testMultiplyToMax64Bit() {
        let a = UInt256(decimalStringValue: "4294967295")
        let c = UInt256(decimalStringValue: "18446744065119617025")
        
        var res:UInt256 = 0
        
        #if DEBUG
            res = a * a  // 0.9999999...% of 64 bit max
        #else
        self.measureBlock() {
            for _ in 1...self.million {
                res = a * a
            }
        }
        #endif
    
        XCTAssertEqual(res, c, res.description);
        
        
    }
    
    func testMultiplyToMax128BitNoKaratsubaOverflow() {
        var a = UInt256(hexStringValue: "1000200030004000")
        var c = UInt256(hexStringValue: "10004000a0014001900180010000000")
        
        var res:UInt256 = 0
        

        res = a * a

        
        XCTAssertEqual(res, c, res.toHexString);
        
        res = 0
        
        a = UInt256(decimalStringValue: "8373049358093547092")
        c = UInt256(decimalStringValue: "70107955553070761001235484930421656464")
        
        res = a * a
        
        XCTAssertEqual(res, c, res.toHexString);
        
        res = 0

        
        a = UInt256(decimalStringValue: "4514341311903373517")
        c = UInt256(decimalStringValue: "20379277480357471495929005285216949289")
        
        res = a * a
        
        XCTAssertEqual(res, c, res.toHexString);
        
        res = 0

        
        a = UInt256(decimalStringValue: "8324499029011133232")
        c = UInt256(decimalStringValue: "69297284084007299998947387404854765824")
        
        self.measureBlock() {
            for _ in 1...self.million / 100 {
                res = a * a
            }
        }
        
        XCTAssertEqual(res, c, res.toHexString);
        
    }
    
    func testMultiplyToMax128BitWithKaratsubaOverflow() {
        var a = UInt256(decimalStringValue: "6907831480921755401") // Also overflows res[1]+= z1 >> 32
        var c = UInt256(hexStringValue: "23e62dbc72dfd1301d69c1b13fb60e51")
        
        var res:UInt256 = 0
        
        res = a * a // result[0] is 1 to high
        
        XCTAssertEqual(res, c, res.toHexString);
        
        a = UInt256(decimalStringValue: "8865396608531244567")
        c = UInt256(hexStringValue: "3b20e559aa2e5076fa2b512bdeb0d611")
        
        res = a * a // result[0] is 1 to high
        
        XCTAssertEqual(res, c, res.toHexString);
        
        a = UInt256(decimalStringValue: "9654263533683468436")
        c = UInt256(decimalStringValue: "93204804377810410884729817879008286096")
        
        res = a * a
        
        XCTAssertEqual(res, c, res.toHexString);
        
        
        a = UInt256(decimalStringValue: "18446744073709551614") // 0.9999999...% of 128 bit max
        c = UInt256(decimalStringValue: "340282366920938463389587631136930004996")
        
        
        self.measureBlock() {
        
            for _ in 1...self.million / 100 {
                res = a * a  // 0.9999999...% of 128 bit max
            }
    
        }
        
        XCTAssertEqual(res, c, res.toHexString);
    }
    
    func testMultiplyToMax128BitWithKaratsubaOverflowPart2() {
        var a: UInt256 = UInt256(decimalStringValue: "9654263533683468436")
        var c: UInt256 = UInt256(hexStringValue: "461e97a5a38a54c61541d2cd28949590")

        var res: UInt256 = a * a // Overflow 1 to high

        XCTAssertEqual(res, c, res.toHexString);


        a = UInt256(decimalStringValue: "18446744073709551614") // 0.9999999...% of 128 bit max
        c = UInt256(decimalStringValue: "340282366920938463389587631136930004996")

        res = a * a

        XCTAssertEqual(res, c, res.toHexString);
    }
    
    func testMultiplyToMax256Bit() {
        let a = UInt256(decimalStringValue: "340282366920938463463374607431768211455")
        let c = UInt256(decimalStringValue: "115792089237316195423570985008687907852589419931798687112530834793049593217025")
        
        var res:UInt256 = 0
        
        self.measureBlock() {
            
            for _ in 1...self.million / 100 {
                
                res = a * a  // 0.9999999...% of UInt256 max
            }
            
        }
        
        XCTAssertEqual(res, c, res.description);
        
        
    }
    
    func testMultiplicationToTupleWithoutRecursion() {
        let p = UInt256(0xffffffff, 0xffffffff, 0xffffffff,0xffffffff, 0xffffffff,0xffffffff, 0xfffffffe,0xfffffc2f)
        
        
        // a and b chosen such that x₁ + x₀ and y₁_plus_y₀ don't overflow
        let a = UInt256(0x502b5092, 0x9d7b11ed, 0x52d00e63, 0x11cd10ff, 0x92956188, 0xdd566bc4, 0x52d0ebaa, 0x95f8234c)
        
        let b = UInt256(0x17c10759, 0xf6e128f2, 0x0704c711, 0x914fa8bf, 0xaa514b51, 0xa371522d, 0xfc5bd655, 0x162050ce)
        
        let (left, right) = (UInt256(0x07705732, 0x4641effd, 0x378f46bc, 0x92edec71, 0x75c31faf, 0xc2e21a5d, 0x69bfbb9f, 0x07abd941), UInt256(0x98baaae0, 0xf56e67d7, 0x455c1ce2, 0x8617a3a9, 0xc9cd081a, 0x1afb578a, 0xa0e2446b, 0x2a342728))
        
        let product = UInt256(0x42b961bc, 0x4ea293f4, 0xe216ff00, 0xb9de205b, 0xfa5b103e, 0x45a1b1aa, 0x44b97f03, 0xd4c97cb8)
        
        var resLeft: UInt256 = 0
        var resRight: UInt256 = 0
        
        self.measureBlock() {
            for _ in 1...self.million/1000 {
                (resLeft, resRight) = a * b
            }
        }
        
        
        XCTAssertTrue(resLeft == left, resLeft.description);
        XCTAssertTrue(resRight == right, resRight.description);
        
    }
    

    func testMultiplicationInSecp256k1() {
        
            var a = UInt256(0x9b992796, 0x19237faf, 0x0c13c344, 0x614c46a9, 0xe7357341, 0xc6e4e042, 0xa9b1311a, 0x8622deaa)
            
            var b = UInt256(0xe7f1caa6, 0x36baa277, 0x9cfd6cf9, 0x696cf826, 0xf013db03, 0x7aa08f3d, 0x5c2dfaf9, 0xdb5d255b)
            
            
            var (left, right) = (UInt256(0x8cfa2912, 0x94cc8c2c, 0x827a9ef6, 0x977f6b69, 0x1d24b810, 0xf085c437, 0xabd13f27, 0x942da0b5), UInt256(0xede973cf, 0x7a14db61, 0x0dfe857e, 0x382bc650, 0x71af459e, 0x27425f0c, 0x36b67051, 0x0a55b86e))
            
            
            var product = UInt256(0x896cbfe5, 0xdd327035, 0x9b769bff, 0x82996a89, 0x9b57827b, 0xc19576ab, 0x11704459, 0x9336d1f0)
        
        var resLeft: UInt256 = 0
        var resRight: UInt256 = 0
        
        self.measureBlock() {
            for i in 0...self.million/1000 {
                (resLeft, resRight) = a * b
            }
        }
        
        XCTAssertTrue(resLeft == left, resLeft.description);
        XCTAssertTrue(resRight == right, resRight.description);
        

    }
    
    func testModTupleInSecp256k1() {
        
        let p = UInt256(0xffffffff, 0xffffffff, 0xffffffff,0xffffffff, 0xffffffff,0xffffffff, 0xfffffffe,0xfffffc2f)
        
        var (left, right) = (UInt256(0x8cfa2912, 0x94cc8c2c, 0x827a9ef6, 0x977f6b69, 0x1d24b810, 0xf085c437, 0xabd13f27, 0x942da0b5), UInt256(0xede973cf, 0x7a14db61, 0x0dfe857e, 0x382bc650, 0x71af459e, 0x27425f0c, 0x36b67051, 0x0a55b86e))
        
        var mod = UInt256(0x896cbfe5, 0xdd327035, 0x9b769bff, 0x82996a89, 0x9b57827b, 0xc19576ab, 0x11704459, 0x9336d1f0)

        var result: UInt256 = 0
        
        self.measureBlock() {
            for i in 1...(self.million / 1_00) {
                result = (left, right) % p
            }
        }
        
        XCTAssertTrue(result == mod, result.description);

        
    }
    


}
