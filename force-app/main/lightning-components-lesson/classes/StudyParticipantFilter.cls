/**
 * Created by OLga Skrynnikova on 05.09.2019.
 */

public with sharing class StudyParticipantFilter implements SearchFilter{               //класс СП фильтр подгружает заранее написанный поиск
    @AuraEnabled public String status;                                                  //строковое поле статус для верхнего фильтра
    @AuraEnabled public String studyTitleTerm;                                          //и строковое поле поиска название исследования

    public List<String> getFields() {                                                   //метод getFields
        return new List<String>{                                                        //возвращет новый лист
                'Contact__r.Name',                                                      //в таблицу с полями Контакта
                'Clinical_Study__r.Title__c',                                           //Название Исследования и Статуса
                'Status__c'
        };
    }

    public SObjectType getSObjectType() {                                               //возвращаем обьект SP и все его поля
        return Study_Participant__c.getSObjectType();
    }

    public String getFilterString() {                                                   // метод фильтра для open/closed + буквы в названии
        List<String> filters = new List<String>();                                      //новая списковая переменная filters
        if(!String.isEmpty(status)) filters.add(' Status__c = \'' + status + '\'');     //ЕСЛИ поле статус не пустое -> передать в filters Статус = open/closed
        if(!String.isEmpty(studyTitleTerm)) filters.add(                                //ЕСЛИ поле поиска не пустое -> передать в filters
                ' Clinical_Study__r.Title__c LIKE \'%'                                  //в поле с СП названием есть похожая
                + studyTitleTerm + '%\' '                                               //строка из переменной studyTitleTerm
        );
        if (filters.size() > 0) return ' WHERE ' + String.join(filters, ' AND ');       //ЕСЛИ в переменной filters больше 1 списка, то соединить их для запроса
        return '';                                                                      //иначе вернуть пустую строку
    }
}