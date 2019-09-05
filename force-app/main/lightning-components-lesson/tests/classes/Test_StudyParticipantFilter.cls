/**
 * Created by OLga Skrynnikova on 05.09.2019.
 */
@IsTest
private class Test_StudyParticipantFilter {
    @IsTest
    static void testBehavior(){

        Test.startTest();                                                                   //старт тест

        Contact contact = new Contact(LastName = 'TestFiled');                              //Создаем переменную contact
        insert contact;                                                                     //вставляем переменную
        Clinical_Study__c clinicalStudy = new Clinical_Study__c(Title__c = 'MyTitleTest');  //создаем переменную clinicalStudy
        insert clinicalStudy;                                                               //вставляем переменную

        Study_Participant__c studyParticipant = new Study_Participant__c(                   //создаем переменную studyParticipant с указанием
                Contact__c = contact.Id,                                                    //в поле contact__c айдишник нового контакта
                Clinical_Study__c = clinicalStudy.Id                                        //в поле ClinicalStudy айдишник новой созданной Study
        );
        insert studyParticipant;                                                            //вставляем переменную

        StudyParticipantFilter filter = new StudyParticipantFilter();                       //создаем переменную фильтр класса SPF
        filter.status = 'Open';                                                             //с полем статус = опен
        filter.studyTitleTerm = 'Title';                                                    //с полем поиска = титл
        PaginationData paginationData = new PaginationData();                               //создаем новую переменную PaginationData

        SearchResponse response = SearchService.search(filter, paginationData);             //создаем переменную response и вызываем ей метод search в классе searchservice
                                                                                            //передавая ей переменные filter and paginationData
        PaginationData paginationData2 = new PaginationData();
        filter.studyTitleTerm = 'Help';
        SearchResponse response2 = SearchService.search(filter, paginationData2);

        Test.stopTest();

        System.assert(response.paginationData.currentPageCount == 1, 'Wrong records count per current page');
        System.assert(response.pageRecords.size() == 1, 'Wrong records count per current page');

        System.assert(response2.pageRecords.size() == 0, 'Must be empty List');

            }

}