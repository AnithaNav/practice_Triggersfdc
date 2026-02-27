//Write a Trigger to get total amt of all opps of a account in Accout Object's customfield-Total_Opportunity_Amount
trigger TotalOpportunityAmountOnAccount on Account (before update) {
    if (Trigger.isBefore && Trigger.isUpdate) {

        // Getting the Ids of all the records being updated
        Set<Id> accIds = new Set<Id>();
        for (Account acc : Trigger.new) {
            accIds.add(acc.Id);
        }

        // Getting the map of AccountId and TotalAmount
        Map<Id, Double> amountMap = new Map<Id, Double>();
        List<AggregateResult> result = [SELECT AccountId, SUM(Amount) TotalAmount FROM Opportunity WHERE AccountId IN :accIds GROUP BY AccountId];
        //put the rec from ARList to Map (Map is table of accid and Opptotalamt)
        if (result.size() > 0) {
            for (AggregateResult res : result) {
                amountMap.put((Id)res.AccountId, (Double)res.TotalAmount);
            }
        }

        // Iterating over updated accounts to input the Total Opportunity Amount Field
        for (Account acc : Trigger.new) {
            if (amountMap.containsKey(acc.Id)) {
                acc.Total_Opportunity_Amount = amountMap.get(acc.Id);
            }
        }
    }
}
