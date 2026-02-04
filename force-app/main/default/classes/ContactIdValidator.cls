public with sharing class ContactIdValidator {
   public static void validateContactIds(Set<Id> inputContactIds) {

        // Safety check
        if (inputContactIds == null || inputContactIds.isEmpty()) {
            System.debug('No Contact IDs provided.');
            return;
        }

        // Step 1: Query existing Contacts
        Set<Id> existingContactIds = new Set<Id>();

        for (Contact c : [
            SELECT Id
            FROM Contact
            WHERE Id IN :inputContactIds
        ]) {
            existingContactIds.add(c.Id);
        }

        // Step 2: Find missing IDs
        Set<Id> missingContactIds = new Set<Id>();//temp set to store missing ids
        missingContactIds.addAll(inputContactIds);//all input contacts id in missingcontact set
        missingContactIds.removeAll(existingContactIds);//remove will remove all existingdbids from missing set

        // Step 3: Print missing IDs
        if (missingContactIds.isEmpty()) {
            System.debug('All Contact IDs exist in the database.');
        } else {
            System.debug('Contact IDs NOT found in database: ' + missingContactIds);
        }
    }
}
/* pick any 18 digit contact id and create a set of 18 digit contact ids and pass to method
Set<Id> testIds = new Set<Id>{
    '003XXXXXXXXXXXXAAA',
    '003XXXXXXXXXXXXBBB'
};

ContactIdValidator.validateContactIds(testIds);*/