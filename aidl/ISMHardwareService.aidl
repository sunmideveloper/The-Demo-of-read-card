// ISMHardwareService.aidl
package com.sunmi.pay.hardware;

import com.sunmi.pay.hardware.ISMCheckCardCallback;
// Declare any non-default types here with import statements

interface ISMHardwareService {

        /**
          *
          * check card
          * @param timeout
          * @param callback   result callback
          *
          */

       void  onCheckCard(int timeout,in ISMCheckCardCallback callback);

       /**
       	 * IC APDU interface
       	 *
       	 * @param apdu
       	 * @param apdulength
       	 * @param response
       	 * @return
       	 */
       	int ICCSendRecv(in byte[] apdu, int apdulength, out byte[] response);

       	/**
          * NFC APDU interface
          *
          * @param apdu
          * @param apdulength
          * @param response
          * @return
          */
        int PCDSendRecv(in byte[] apdu, int apdulength, out byte[] response);


}
