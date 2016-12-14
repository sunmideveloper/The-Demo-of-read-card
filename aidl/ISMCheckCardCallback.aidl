// ISMCheckCardCallback.aidl
package com.sunmi.pay.hardware;

import java.util.Map;
// Declare any non-default types here with import statements

interface ISMCheckCardCallback {
        /**
         * CARDTYPE_MAG = 1;
         * CARDTYPE_IC = 2;
         * CARDTYPE_NFC = 4;
         * CARDTYPE_SAM = 8
    	 * 检卡成功   ----arg key{CARDTYPE(must convert int),TRACK1 ,TRACK3 ,COUNTRYCODE, CARDHOLDER , EXPIRE , isICCARD  ,ATR, UUID , Expiry , ServCode , EChase ,PAN}
    	 */
    	void checkSucceed(in Map arg);

    	/**
    	 * 检卡失败
    	 */
    	void checkError(int code);

    	/**
    	 * 未取得有效卡信息
    	 */
    	void checkNoValidInfo();
}
