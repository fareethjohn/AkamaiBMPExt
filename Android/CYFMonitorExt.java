package com.example.bmpinitcallback;

import com.akamai.botman.CYFMonitor;

interface SensorDataHandler
{
    void handle(String sensorData);
}

public class CYFMonitorExt {
    long kSD_Sampling_Time = 1000;
    int kSD_TimeOut = 30;
    String kSD_default_mobile = "default-mobile";

    synchronized void getSensorDataInHandler(SensorDataHandler h){
        String theSD = CYFMonitor.getSensorData();
        if (theSD.equals(kSD_default_mobile)){
            for (int i=0; i< kSD_TimeOut; i++){
                try {
                    Thread.sleep(kSD_Sampling_Time);
                    theSD = CYFMonitor.getSensorData();
                    if (!theSD.equals(kSD_default_mobile)){
                        break;
                    }
                }catch (InterruptedException ex){
                }
            }
        }
        h.handle(theSD);
    };
}
