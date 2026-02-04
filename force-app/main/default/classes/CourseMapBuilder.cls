public with sharing class CourseMapBuilder {
    public static Map<String, String> getCourseInstructorMap() {

        Map<String, String> courseInstructorMap = new Map<String, String>();

        // Query all Course__c records
        for (Course__c course : [
            SELECT Name__c, Instructor__c
            FROM Course__c
        ]) {
            courseInstructorMap.put(course.Name__c, course.Instructor__c);
            //put into map key is name and value is instructor
        }

        return courseInstructorMap;
    }
}
//Anonymous Apex
//Map<String, String> result = CourseMapBuilder.getCourseInstructorMap();

//System.debug('Course → Instructor Map: ' + result);