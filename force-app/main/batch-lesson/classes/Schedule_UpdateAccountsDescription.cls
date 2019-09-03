/**
 * Created by user on 03.09.2019.
 */

public with sharing class Schedule_UpdateAccountsDescription implements Schedulable{

    public void execute(SchedulableContext param1) {
        Batch_SetAccountDescription.run();
    }

    public static void run() {
        System.schedule('Update Account Description', '0 0 12 1/1 * ? *', new Schedule_UpdateAccountsDescription());
    }
}