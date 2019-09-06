/**
 * Created by OLga Skrynnikova on 05.09.2019.
 */

public with sharing class PaginationData {
    @AuraEnabled public Integer allRecordsCount;
    @AuraEnabled public Integer pagesCount;
    @AuraEnabled public Integer pageRecordsCount;
    @AuraEnabled public Integer currentPage;
    @AuraEnabled public Integer offset;
    @AuraEnabled public Integer endOffset;
    @AuraEnabled public Integer currentPageCount;

    public PaginationData() {
        currentPage = 1;
        pageRecordsCount = 5;
    }

    public void setRecordsCount(Integer allRecordsCount) {
        this.allRecordsCount = allRecordsCount;
        recalc();
    }

    public void recalc() {
        System.debug('>>> ' + JSON.serializePretty(this));
        Decimal allRecordsCountDecimal = allRecordsCount;
        Decimal pageRecordsCountDecimal = pageRecordsCount;
        Decimal allPagesDecimal = allRecordsCountDecimal/pageRecordsCountDecimal;
        allPagesDecimal = allPagesDecimal.round(System.RoundingMode.UP);
        pagesCount = allPagesDecimal.intValue() == 0 ? 1 : allPagesDecimal.intValue();

        if (currentPage > allPagesDecimal) currentPage = allPagesDecimal == 0 ? 1 : allPagesDecimal.intValue();

        offset = (currentPage - 1) * pageRecordsCount;
        endOffset = offset + pageRecordsCount;

        if (endOffset > allRecordsCount) endOffset = allRecordsCount;

        currentPageCount = endOffset - offset;
        System.debug('>>> ' + JSON.serializePretty(this));
    }
}