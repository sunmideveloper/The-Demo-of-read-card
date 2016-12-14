
Sunmi P1 (some times we call it V2) can do lots of financial payment work, here we will explain the basic development of P1 by showing a simple demonstration : to read the Bank Card and showing the card number on a TextView.

Please refer to the following steps:

1.Installing the SunmiPayHardwareService.apk into your P1 device, click the icon on the Launcher to start it. You can find the apk in the sources file.

2.Downloading the TestPay_AndroidStudio.zip and improting the TestPay_AndroidStudio project into your AndroidStuio ,of course you can download the TesetPay_eclipse if you are an eclipse advocate.

3.Deploying the TestPay in your deivce(You an downloading those two apk files and install on your devices directly), click the TestPay icon in the Launcher, take out your BankCard(Maybe a   MasterCard ), clicking the ‘Click me and swiping card...’ button in the Demo. You know the next step is swiping card.

You got three ways to let the device identify the card below :

NFC:

![Alt SUNMI](https://github.com/sunmideveloper/The-Demo-of-read-card/blob/master/img/1.png) 

IC:

![Alt SUNMI](https://github.com/sunmideveloper/The-Demo-of-read-card/blob/master/img/2.png) 

Swiping from right to left:

![Alt SUNMI](https://github.com/sunmideveloper/The-Demo-of-read-card/blob/master/img/3.jpeg) 

#### The TextView on the Demo will show the Bank Card number if the card is recognized by the device.

Now , I will explain  the code of the way to identify the card number base on the TestPay Demo:

1.Copying those two AIDL files into the specified package com.sunmi.pay.hardware of your project.

2.Connecting the Service when the Demo is started.
```

Intent intent = new Intent("sunmi.intent.action.PAY_HARDWARE");
intent.setPackage("com.sunmi.pay.hardware");
bindService(intent, mConnection, Service.BIND_AUTO_CREATE);

```

the mConnection above is as follow, you can initialize the ISMHardwareService in the onServiceConnected method.

```
private ServiceConnection mConnection = new ServiceConnection() {
    @Override
    public void onServiceConnected(ComponentName componentName, IBinder iBinder) {
            mHardwareService = ISMHardwareService.Stub.asInterface(iBinder);//Initializing the ISMHardwareService 
            Log.i("sunmi"."Service status: connected!");
          }

    @Override
    public void onServiceDisconnected(ComponentName componentName) {
        mHardwareService = null;
       Log.i("sunmi"."Service status: disconnected!");
         }
};

```

3.Calling the ISMHardwareService .onCheckCard(int period, ISMCheckCardCallback callback) on the button's OnClickListener

```
 mBtnCheckCard.setOnClickListener(new View.OnClickListener() {
                    @Override
                    public void onClick(View view) {
                        if (mHardwareService == null) {
Toast.makeText(MainActivity.this, "Can't connect to the remote service, retry it later!", Toast.LENGTH_SHORT).show();
                        } else {
                            try {
                                mHardwareService.onCheckCard(30, callback);//the first param is the waiting period of the Demo，you must finish the Swiping work in 30 seconds
                            } catch (RemoteException e) {
                                e.printStackTrace();
Toast.makeText(MainActivity.this, "remote service exception，can't call it！", Toast.LENGTH_SHORT).show();
                            }
                        }
                    }
                });

```

the callback above is as following: 
```
ISMCheckCardCallback callback = new ISMCheckCardCallback.Stub() {

                @Override
                public void checkSucceed(final Map arg) throws RemoteException {
                    if (arg != null) {
                        
Log.i("sunmi",(String) arg.get("PAN"));//Getting the card number.
Log.i("sunmi",(String) arg.get("CARDTYPE"));//Getting the card type
Log.i("sunmi",(String) arg.get("TRACK1"));
Log.i("sunmi",(String) arg.get("TRACK3"));
Log.i("sunmi",(String) arg.get("COUNTRYCODE"));
Log.i("sunmi",(String) arg.get("CARDHOLDER"));
Log.i("sunmi",(String) arg.get("EXPIRE"));
Log.i("sunmi",(String) arg.get("ATR"));
Log.i("sunmi",(String) arg.get("UUID"));
                    }
                }

                @Override
                public void checkError(int code) throws RemoteException {
                    changeOnUiText("reading card error：" + code);
Log.i("sunmi","reading card error：" + code);             
                }

                @Override
                public void checkNoValidInfo() throws RemoteException {
               
Log.i("sunmi","fail to read the card's information available!");             
                    
                }
            };

```
