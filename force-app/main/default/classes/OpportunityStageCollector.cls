public with sharing class OpportunityStageCollector {
    public class OpportunityStageCollector {

    public static void printUniqueStageNames() {

        // Set to store unique Stage Names
        Set<String> uniqueStages = new Set<String>();

        // Query Opportunities
        for (Opportunity opp : [
            SELECT StageName
            FROM Opportunity
        ]) {
            uniqueStages.add(opp.StageName);
        }

        // Print result
        System.debug('Unique Opportunity Stage Names: ' + uniqueStages);
    }
}

}
//AnonyApex-call this method 
//OpportunityStageCollector.printUniqueStageNames();