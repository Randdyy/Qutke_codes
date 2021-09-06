function rsaPublicKeyPem() {

    function prepadSigned(hexStr) {
        msb = hexStr[0]
        if (
            (msb>='8' && msb<='9') || 
            (msb>='a' && msb<='f') || 
            (msb>='A'&&msb<='F')) {
            return '00'+hexStr;
        } else {
            return hexStr;
        }
    }

    function toHex(number) {
        var nstr = number.toString(16)
        if (nstr.length%2==0) return nstr
        return '0'+nstr
    }

    // encode ASN.1 DER length field
    // if <=127, short form
    // if >=128, long form
    function encodeLengthHex(n) {
        if (n<=127) return toHex(n)
        else {
            n_hex = toHex(n)
            length_of_length_byte = 128 + n_hex.length/2 // 0x80+numbytes
            return toHex(length_of_length_byte)+n_hex
        }
    }
    var modulus_b64 = 'srpKIOhwy7AWKLEdC7ybjqeaqd0pIaZf3qiNMU43JgXMBMd/jOGaIRsUQ25hajEg/d1XgzZcMeZNVpUHVTJz13pZv7+YlIDqwzeDMtQWRXbpEWA8L08Pu3/mbrKdY8pmF7dkdEDShD6wv9M6hMu/sjPV9S7YslVSGRPRgw1jsBk='
    var exponent_b64 = 'AQAB'
    var modulus = new Buffer(modulus_b64,'base64');
    var exponent = new Buffer(exponent_b64, 'base64');

    var modulus_hex = modulus.toString('hex')
    var exponent_hex = exponent.toString('hex')

    modulus_hex = prepadSigned(modulus_hex)
    exponent_hex = prepadSigned(exponent_hex)

    var modlen = modulus_hex.length/2
    var explen = exponent_hex.length/2

    var encoded_modlen = encodeLengthHex(modlen)
    var encoded_explen = encodeLengthHex(explen)
    var encoded_pubkey = '30' + 
        encodeLengthHex(
            modlen + 
            explen + 
            encoded_modlen.length/2 + 
            encoded_explen.length/2 + 2
        ) + 
        '02' + encoded_modlen + modulus_hex +
        '02' + encoded_explen + exponent_hex;

    var seq2 = 
        '30 0d ' +
          '06 09 2a 86 48 86 f7 0d 01 01 01' +
          '05 00 ' +
        '03' + encodeLengthHex(encoded_pubkey.length/2 + 1) +
        '00' + encoded_pubkey;

    seq2 = seq2.replace(/ /g,'');

    var der_hex = '30' + encodeLengthHex(seq2.length/2) + seq2;

    der_hex = der_hex.replace(/ /g, '');

    var der = new Buffer(der_hex, 'hex');
    var der_b64 = der.toString('base64');

    var pem = '-----BEGIN PUBLIC KEY-----\n' 
        + der_b64.match(/.{1,64}/g).join('\n') 
        + '\n-----END PUBLIC KEY-----\n';
    console.log(pem)
    return pem
}


setTimeout(rsaPublicKeyPem,500);
/*
<RSAKeyValue>
    <Modulus>srpKIOhwy7AWKLEdC7ybjqeaqd0pIaZf3qiNMU43JgXMBMd/jOGaIRsUQ25hajEg/d1XgzZcMeZNVpUHVTJz13pZv7+YlIDqwzeDMtQWRXbpEWA8L08Pu3/mbrKdY8pmF7dkdEDShD6wv9M6hMu/sjPV9S7YslVSGRPRgw1jsBk=</Modulus>
    <Exponent>AQAB</Exponent>
    </RSAKeyValue>
    */


// <RSAKeyValue>
// <Modulus>pZF8ccW0cuAQ86ZKQXxIQrDLKXxB7iWkIXGrfPO3bHuub47TAuWIehZvzM
// OnJ+bVC2ZRvkcUgJwM7IYyDIrk7V/OfyMt9pdsKb1fGMvhhIyPl/Q4ozpeZy1ch1atPWq2SFXQeOGiCW
// Kz+UwEhWrDyEhzZiJAkPqcZwRHPM7cBF8=</Modulus>
// <Exponent>AQAB</Exponent>
// <P>7fF3nKIE
// 2XGONwBC4rI0IK1sRZ8t2LK38xRKJae4h7CJQCqcvKf091OOiDLULdRzhJSNga9l0Wm14EotREF9aQ==
// </P>
// <Q>siH8/rd6WNnzfDEbyxPbaSZYuuBuGkMFT2VL3I6yT3dLwXGEgCQgdAB75/h1WlqqruDOH5Rr7
// 1uAH4WTrcWShw==</Q>
// <DP>gLqie5ssBHfq+NarWPoQOZ2ZdhEoPJRz8I6JjtWuf7qChrSHF4nGfgg2l
// HjrUeAenxu/cunxq9oFC9MVqlfEAQ==</DP>
// <DQ>WF0f4UMm//huHkdGIEEjcE/DaEB4nbJtaes37Jsk
// vOLSw40KS36gUqsCzBmmLUIYtVNzLJs1x7C+J+TdUzBU9Q==</DQ>
// <InverseQ>fdZrfvVqdQHdu3tl4
// wlljqIJrjV4lilDgJv3FNcYX5eeIZROzciZdckxhKYT5HnzSCait47xjGeFvZdI+r5Gqg==</InverseQ>
// <D>jMzVjJd6JnsAT4PqABimBvj8PNJr6w9drgdRs9g682mW5U4LipoSXuj3uKXmYBuAr8oa1/rwp5K
// NtxNEOsBff1C0ynbKq6J3jA/j5TQ3W2Gwwuv7PQJwMpgK2PpgdiF/8fn47VPDk06a6bFS4weEL8Pcaqh
// YyHJy2z+WMOKSwzE=</D>
// </RSAKeyValue>


// <RSAKeyValue> 
//   <Modulus>pZF8ccW0cuAQ86ZKQXxIQrDLKXxB7iWkIXGrfPO3bHuub47TAuWIehZvzM OnJ+bVC2ZRvkcUgJwM7IYyDIrk7V/OfyMt9pdsKb1fGMvhhIyPl/Q4ozpeZy1ch1atPWq2SFXQeOGiCW Kz+UwEhWrDyEhzZiJAkPqcZwRHPM7cBF8=</Modulus>  
//   <Exponent>AQAB</Exponent>  
//   <P>7fF3nKIE 2XGONwBC4rI0IK1sRZ8t2LK38xRKJae4h7CJQCqcvKf091OOiDLULdRzhJSNga9l0Wm14EotREF9aQ==</P>  
//   <Q>siH8/rd6WNnzfDEbyxPbaSZYuuBuGkMFT2VL3I6yT3dLwXGEgCQgdAB75/h1WlqqruDOH5Rr7 1uAH4WTrcWShw==</Q>  
//   <DP>gLqie5ssBHfq+NarWPoQOZ2ZdhEoPJRz8I6JjtWuf7qChrSHF4nGfgg2l HjrUeAenxu/cunxq9oFC9MVqlfEAQ==</DP>  
//   <DQ>WF0f4UMm//huHkdGIEEjcE/DaEB4nbJtaes37Jsk vOLSw40KS36gUqsCzBmmLUIYtVNzLJs1x7C+J+TdUzBU9Q==</DQ>  
//   <InverseQ>fdZrfvVqdQHdu3tl4 wlljqIJrjV4lilDgJv3FNcYX5eeIZROzciZdckxhKYT5HnzSCait47xjGeFvZdI+r5Gqg==</InverseQ>  
//   <D>jMzVjJd6JnsAT4PqABimBvj8PNJr6w9drgdRs9g682mW5U4LipoSXuj3uKXmYBuAr8oa1/rwp5K NtxNEOsBff1C0ynbKq6J3jA/j5TQ3W2Gwwuv7PQJwMpgK2PpgdiF/8fn47VPDk06a6bFS4weEL8Pcaqh YyHJy2z+WMOKSwzE=</D> 
// </RSAKeyValue>
