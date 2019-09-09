/**
 * Created by OLga Skrynnikova on 06.09.2019.
 */

public with sharing class AccountPanelRemote {
    public class InitData{
        @AuraEnabled public AccountFilter filter = new AccountFilter();
        @AuraEnabled public PaginationData pagination = new PaginationData();
        @AuraEnabled public Account[] pageRows;

    }

    @AuraEnabled
    public static InitData getInitData() {
        InitData initData = new InitData();
        SearchResponse searchResponse = SearchService.search(initData.filter, initData.pagination);
        initData.pageRows = (Account[])searchResponse.pageRecords;
        initData.pagination = searchResponse.paginationData;
        return initData;
    }

    @AuraEnabled
    public static SearchResponse search(String filter, String pagination){
        return SearchService.search(
                (AccountFilter)JSON.deserialize(filter, AccountFilter.class),
                (PaginationData)JSON.deserialize(pagination, PaginationData.class)
        );
    }
}