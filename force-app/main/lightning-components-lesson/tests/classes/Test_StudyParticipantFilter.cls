/**
 * Created by OLga Skrynnikova on 05.09.2019.
 */
@IsTest
private class Test_StudyParticipantFilter {
    @IsTest
    static void testBehavior() {

        Test.startTest();                                                                   //СТАРТ

        Contact contact = new Contact(LastName = 'TestFiled');                              //Создаем переменную contact
        insert contact;                                                                     //вставляем переменную
        Clinical_Study__c clinicalStudy = new Clinical_Study__c(                            //создаем переменную clinicalStudy
                Title__c = 'MyTitleTest');
        insert clinicalStudy;                                                               //вставляем переменную

        Study_Participant__c studyParticipant = new Study_Participant__c(                   //создаем переменную studyParticipant с указанием
                Contact__c = contact.Id,                                                    //в поле contact__c айдишник нового контакта
                Clinical_Study__c = clinicalStudy.Id                                        //в поле ClinicalStudy айдишник новой созданной Study
        );
        insert studyParticipant;                                                            //вставляем переменную

        StudyParticipantFilter filter = new StudyParticipantFilter();                       //создаем переменную фильтр
        filter.status = 'Open';                                                             //с полем статус = опен
        filter.studyTitleTerm = 'Title';                                                    //с полем поиска = титл
        PaginationData paginationData = new PaginationData();                               //создаем новую переменную PaginationData для перерасчета страницы
        SearchResponse response = SearchService.search(filter, paginationData);             //создаем переменную response и вызываем ей метод search в классе searchservice
                                                                                            // передавая ей переменные filter and paginationData

        PaginationData paginationData2 = new PaginationData();                               //создаем вторую переменную для пагинации и респонсе
        SearchResponse response2 = SearchService.search(filter, paginationData2);           //передавая ей тот же фильтр, но другую переменную пагинации

        Test.stopTest();                                                                    //СТОП

        System.assert(response.paginationData.currentPageCount == 1,                        //Проверка текущая страница == 1 или ошибка
                'Wrong records count per current page');
        System.assert(response.pageRecords.size() == 1,                                     //Проверка текущее число записей 1 или ошибка
                'Wrong records count per current page');
        System.assert(response2.pageRecords.size() == 0,                                    ////Проверка текущее число записей 0 или ошибка
                'Must be empty List');

    }

    @IsTest
    private static void test2() {
        Clinical_Study__c clinicalStudy = new Clinical_Study__c(
                Title__c = 'TitleTest'
        );
        insert clinicalStudy;

        for (Integer i = 0; i < 7; i++) {
            Contact contact = new Contact(
                    LastName = 'TestName' + i
            );
            insert contact;
            Study_Participant__c studyParticipant = new Study_Participant__c(
                    Contact__c = contact.Id,
                    Clinical_Study__c = clinicalStudy.Id,
                    Status__c = 'Open'
            );
            insert studyParticipant;
        }
        StudyParticipantPanelRemote.InitData initData = StudyParticipantPanelRemote.getInitData();
        System.assert(initData.pagination.pagesCount == 2,
                'Wrong number of pages:' + initData.pagination.pagesCount);

        initData.pagination.currentPage = 2;
        SearchResponse searchResponse = StudyParticipantPanelRemote.search(
                JSON.serialize(initData.filter),
                JSON.serialize(initData.filter));
        System.assert(searchResponse.pageRecords.size() == 2,
                'Wrong record number: ' + searchResponse.pageRecords.size());
    }
}



