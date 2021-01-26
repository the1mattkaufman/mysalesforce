public class AccountCalculator {
  /**
   * @name Calculate
   */
  public static void Calculate(List<Account> accs) {
    Map<Id, Account> toUpdate = new Map<Id, Account>(accs);
    for (Account a : [
      SELECT
        Id,
        BillingState,
        Industry,
        (
          SELECT Id, Amount
          FROM Opportunities
          WHERE IsWon = TRUE
          ORDER BY CloseDate DESC
          LIMIT 1
        )
      FROM Account
      WHERE Id IN :toUpdate.keySet()
    ]) {
      a.Score__c = 0;
      if (a.Opportunities.size() > 0) {
        a.Score__c += 50;
      }
      if (String.isNotBlank(a.Industry)) {
        a.Score__c += 20;
      }
      toUpdate.put(a.Id, a);
    }
    update toUpdate.values();
  }
}
