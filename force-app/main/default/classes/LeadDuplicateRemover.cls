public with sharing class LeadDuplicateRemover {
    //Usecase:remove duplicate Lead records from a List,2 leads with same email id remove 1 & store using a Set.
    //Input is List of Leads with duplicate records-email field is same for duplicate records
    //Action -process through the list check email same,if duplicate delete the duplicate record and store in set .
    //Output is set of Leads with one email field for each record
   public static List<Lead> removeDuplicateLeadsByEmail(List<Lead> leads) {

        // Safety check on input List of leads
        if (leads == null || leads.isEmpty()) {
            return new List<Lead>();//
        }

        Set<String> emailSet = new Set<String>();//create a set to store only unique email field
        List<Lead> uniqueLeads = new List<Lead>();//output list to store final unique leads

        for (Lead l : leads) {

            // Skip leads without email (optional rule)
            if (String.isBlank(l.Email)) {
                uniqueLeads.add(l);// add the Lead with empty email field to new  uniquelist,not blank proceed
                continue;//skips to the next iteration of the loop,so next rec is taken ,rest not excuted

            }

            // Add lead only if email not already processed
            //first check if email exist in emailset ,if no in set ,put email field to  set & to Unique List
            // Duplicate emails if detected ,if st will not excute ,so that rec not in unique list
            if (!emailSet.contains(l.Email)) {
                emailSet.add(l.Email);
                uniqueLeads.add(l);
            }
        }

        return uniqueLeads;
    }
}
//to check : enter from Anonymous window this
/*List<Lead> leadList = [
    new Lead(LastName='A', Company='ABC', Email='test@email.com'),
    new Lead(LastName='B', Company='XYZ', Email='test@email.com'),
    new Lead(LastName='C', Company='PQR', Email='unique@email.com')
];

List<Lead> result = LeadDuplicateRemover.removeDuplicateLeadsByEmail(leadList);

System.debug(result);*/
