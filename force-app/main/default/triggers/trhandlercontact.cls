Class trhandlercontact{
    public static void updateContactPhones(List<Account> newAccounts, 
                                           Map<Id, Account> oldAccountMap) {

        Set<Id> accountIds = new Set<Id>();
        Map<Id, String> accountPhoneMap = new Map<Id, String>();

        // Step 1: Identify Accounts where Phone changed,loop through newAccountslist
        for(Account acc : newAccounts) {
            Account oldAcc = oldAccountMap.get(acc.Id);//get oldrecphone in  a single accvariable

            if(acc.Phone != oldAcc.Phone) {//when phone is changed
                accountIds.add(acc.Id);//add the accid to set
                accountPhoneMap.put(acc.Id, acc.Phone);//also put in Map for quick lookup/search onlychngd phn
            }
        }
        //safecheck on empty set
        if(accountIds.isEmpty()) {
            return;
        }

        //Step2: now you have accid in set where phn changed ,you have chg contact now ,Fetch related Contacts
        List<Contact> contactsToUpdate = [
            SELECT Id, Phone, AccountId
            FROM Contact
            WHERE AccountId IN :accountIds
        ];

        // Step 3: Update Contact Phone,loop thru contact list
        for(Contact con : contactsToUpdate) {
            String parentPhone = accountPhoneMap.get(con.AccountId);
            
            if(con.Phone != parentPhone) {
                con.Phone = parentPhone;
            }
        }

        if(!contactsToUpdate.isEmpty()) {
            update contactsToUpdate;
        }
    }
}