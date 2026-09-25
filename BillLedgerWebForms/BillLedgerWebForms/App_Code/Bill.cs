using System;

/// <summary>
/// Represents a single bill entry.
/// </summary>
public class Bill
{
    public Guid Id { get; set; }
    public string Owner { get; set; }          // username the bill belongs to
    public string Name { get; set; }
    public string Category { get; set; }
    public decimal Amount { get; set; }
    public DateTime DueDate { get; set; }
    public int ReminderDays { get; set; }       // 1, 2 or 3
    public string Status { get; set; }          // "Paid" or "Pending"

    public int DaysUntilDue()
    {
        return (DueDate.Date - DateTime.Today).Days;
    }

    public bool IsDueSoon()
    {
        var d = DaysUntilDue();
        return Status == "Pending" && d >= 0 && d <= ReminderDays;
    }

    public bool IsOverdue()
    {
        return Status == "Pending" && DaysUntilDue() < 0;
    }
}
