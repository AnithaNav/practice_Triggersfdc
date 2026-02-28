trigger AccountPhoneSyncTrigger on Account (after update) {
  
   if(Trigger.isAfter && Trigger.isUpdate){
       trhandlercontact.updateContactPhones(Trigger.new, Trigger.oldMap);
   }
}
