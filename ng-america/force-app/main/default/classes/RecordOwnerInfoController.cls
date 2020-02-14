public without sharing class RecordOwnerInfoController { 
    @AuraEnabled
    public static User getRecordOwnerInfo(string recordId) {
        String sObjName = ((Id)recordId).getSObjectType().getDescribe().getName();
        string query = 'select Id, OwnerId from '+sObjName + ' where id =:recordId limit 1';
		sObject record = Database.query(query);
        string ownerId = string.valueOf(record.get('OwnerId'));
        if(ownerId != null){
            User oUser = [select Id, Name, SmallPhotoUrl, FullPhotoUrl 
                 FROM User Where id =: ownerId];
            return oUser;
        }
        return null;
    }
}