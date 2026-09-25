using System;
using System.Collections.Generic;
using System.Linq;

/// <summary>
/// Simple thread-safe in-memory store for bills.
/// NOTE: this is intentionally lightweight for a demo/tiny project.
/// Data lives only as long as the application is running (it resets
/// on an app pool recycle). Swap this out for a database-backed
/// repository (ADO.NET / EF) for anything production-facing.
/// </summary>
public static class BillRepository
{
    private static readonly List<Bill> _bills = new List<Bill>();
    private static readonly object _lock = new object();

    public static List<Bill> GetByOwner(string owner)
    {
        lock (_lock)
        {
            return _bills.Where(b => b.Owner == owner)
                          .OrderBy(b => b.DueDate)
                          .ToList();
        }
    }

    public static Bill GetById(Guid id)
    {
        lock (_lock)
        {
            return _bills.FirstOrDefault(b => b.Id == id);
        }
    }

    public static void Add(Bill bill)
    {
        lock (_lock)
        {
            bill.Id = Guid.NewGuid();
            _bills.Add(bill);
        }
    }

    public static void Update(Bill bill)
    {
        lock (_lock)
        {
            var existing = _bills.FirstOrDefault(b => b.Id == bill.Id);
            if (existing == null) return;
            existing.Name = bill.Name;
            existing.Category = bill.Category;
            existing.Amount = bill.Amount;
            existing.DueDate = bill.DueDate;
            existing.ReminderDays = bill.ReminderDays;
            existing.Status = bill.Status;
        }
    }

    public static void Delete(Guid id)
    {
        lock (_lock)
        {
            _bills.RemoveAll(b => b.Id == id);
        }
    }
}
