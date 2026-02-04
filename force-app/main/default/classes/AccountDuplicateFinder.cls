public with sharing class AccountDuplicateFinder {
    public static Set<String> findDuplicateAccountNames() {
// Step 1.create 2 set to store unique and duplicate names
        Set<String> uniqueNames = new Set<String>();//for acc name storing 
        Set<String> duplicateNames = new Set<String>();

        // Query db for Accounts
        for (Account acc : [
            SELECT Id, Name
            FROM Account
            WHERE Name != NULL
        ]) {

            // If acc name already exists in uniquelist,mark asduplicate
            if (uniqueNames.contains(acc.Name)) {
                duplicateNames.add(acc.Name);//if true ,put that accname to duplicate set
            } else {
                uniqueNames.add(acc.Name);//else put in unique set for first time,likethis seperate duplicate accounts
            }
        }

        return duplicateNames;
    }
}
//From Anonymous Apex: Set<String> duplicates = AccountDuplicateFinder.findDuplicateAccountNames();
//System.debug('Duplicate Account Names: ' + duplicates);