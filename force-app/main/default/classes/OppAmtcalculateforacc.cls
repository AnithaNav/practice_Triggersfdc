public with sharing class OppAmtcalculateforacc {

    /**
     * Returns a map where:
     * Key   = StageName
     * Value = List of Opportunity Ids in that stage
     */
    public static Map<String, List<Id>> getOpportunityIdsByStage() {
//Declare a Map-key is Stagename of OppString datatype & Value is Ids of Opp
        Map<String, List<Id>> stageToOppIdsMap = new Map<String, List<Id>>();

        // Query Opportunities from DB 
        List<Opportunity> opps = [
            SELECT Id, StageName
            FROM Opportunity
            WHERE StageName != null
        ];
//Loop through this Opp rec in list 1 by 1 
        for (Opportunity opp : opps) {

            // 1st chk Opp stagename is in map as it is key  and Initialize list if stage not yet in map
            if (!stageToOppIdsMap.containsKey(opp.StageName)) {
                stageToOppIdsMap.put(opp.StageName, new List<Id>());
            }

            // Add Opportunity Id to the stage list
            stageToOppIdsMap.get(opp.StageName).add(opp.Id);
        }

        return stageToOppIdsMap;
    }
}
