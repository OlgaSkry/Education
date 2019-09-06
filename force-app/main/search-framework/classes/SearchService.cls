/**
 * Created by OLga Skrynnikova on 05.09.2019.
 */

public with sharing class SearchService {
    public static SearchResponse search(SearchFilter searchFilter, PaginationData paginationData) {

        String countQuery = 'SELECT COUNT()' +
                ' FROM ' + searchFilter.getSObjectType() + ' ' + searchFilter.getFilterString();
    System.debug('>>>' + countQuery);
        Integer allRecordsCount = Database.countQuery(countQuery);
        paginationData.setRecordsCount(allRecordsCount);

        String query = 'SELECT ' + String.join(searchFilter.getFields(), ',') +
                ' FROM ' + searchFilter.getSObjectType() + ' ' + searchFilter.getFilterString() + ' ' +
                ' LIMIT ' + paginationData.pageRecordsCount +
                ' OFFSET ' + paginationData.offset + ' ';
        System.debug('>>>' + query);
        List<SObject> pageRecords = Database.query(query);
        return new SearchResponse(pageRecords, paginationData);
    }
}