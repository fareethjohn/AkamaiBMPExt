import { NativeModules } from 'react-native';
const { AkamaiBMP } = NativeModules;


export class AkamaiBMPExt {
  constructor() { 

   }
   
   getSensorData() {
    let kSD_TimeOut = 30;//sampling timeout
    let kSD_Sampling_Time = 500;
    let kSD_default_mobile = "default-mobile";
    return new Promise((resolve) => {
        AkamaiBMP.getSensorData((sd) => {
          let theSD = sd;
          if (theSD == kSD_default_mobile){
            let total_Sampling_time = 0;
            function getNewSD(){
              setTimeout(()=> {
                AkamaiBMP.getSensorData((sd) => {
                  theSD = sd
                  total_Sampling_time += kSD_Sampling_Time;
                  if (total_Sampling_time >= kSD_TimeOut*1000 || theSD != kSD_default_mobile){
                    resolve(theSD);
                  }
                  else{
                    getNewSD();
                  }
                }); 
              }, kSD_Sampling_Time);  
            }
            getNewSD();  
          }
          else{
            resolve(theSD);
          }
        });
    })
  }
}  
