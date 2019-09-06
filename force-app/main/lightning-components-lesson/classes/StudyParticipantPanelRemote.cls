/**
 * Created by OLga Skrynnikova on 06.09.2019.
 */

public with sharing class StudyParticipantPanelRemote {
    public class InitData{
        @AuraEnabled public StudyParticipantFilter filter = new StudyParticipantFilter();
        @AuraEnabled public PaginationData pagination = new PaginationData();
        @AuraEnabled public Study_Participant__c[] pageRows;

    }

    @AuraEnabled
    public static InitData getInitData() {
        InitData initData = new InitData();
        SearchResponse searchResponse = SearchService.search(initData.filter, initData.pagination);
        initData.pageRows = (Study_Participant__c[])searchResponse.pageRecords;
        initData.pagination = searchResponse.paginationData;
        return initData;
            }

    @AuraEnabled
    public static SearchResponse search(String filter, String pagination){
        return SearchService.search(
                (StudyParticipantFilter)JSON.deserialize(filter, StudyParticipantFilter.class),
                (PaginationData)JSON.deserialize(pagination, PaginationData.class)
        );
    }
}