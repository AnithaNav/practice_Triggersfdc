public with sharing class OpportunityValidator {
    //checks for Opportunity records where the CloseDate is in the past but does not have an associated Account.
    // Use a Set to find those opportunities.
     public static void findOpportunitiesWithoutAccount() {
    // Step 1: Query Opportunities that meet the criteria and put in a default list
        List<Opportunity> oppList = [
            SELECT Id, Name, CloseDate, AccountId
            FROM Opportunity
            WHERE CloseDate < :Date.today()
            AND AccountId = NULL
        ];

        // Step 2: Store Opportunity Ids in a Set,seperate id alone from OppList
        Set<Id> oppWithoutAccountIds = new Set<Id>();

        for (Opportunity opp : oppList) {
            oppWithoutAccountIds.add(opp.Id);//to avoid dupliacates,we put in set
        }

        // Step 3: Output results
        if (oppWithoutAccountIds.isEmpty()) {
            System.debug('No Opportunities found with past CloseDate and no Account.');
        } else {
            System.debug(
                'Opportunities with past CloseDate and no Account: ' + oppWithoutAccountIds
            );
        }
    }
}