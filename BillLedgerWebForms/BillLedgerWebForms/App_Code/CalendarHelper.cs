using System;
using System.Collections.Generic;
using System.Linq;

/// <summary>
/// Builds a Sun-Sat month grid and marks which days have bills due.
/// </summary>
public static class CalendarHelper
{
    public class DayCell
    {
        public int Day;           // 0 = blank/padding cell
        public DateTime Date;
        public bool IsBlank;
        public bool IsToday;
        public int BillCount;
    }

    public static List<DayCell> BuildMonthGrid(int year, int month, List<Bill> bills)
    {
        var cells = new List<DayCell>();
        var first = new DateTime(year, month, 1);
        int leading = (int)first.DayOfWeek; // Sunday = 0
        int daysInMonth = DateTime.DaysInMonth(year, month);

        for (int i = 0; i < leading; i++)
        {
            cells.Add(new DayCell { IsBlank = true });
        }

        var countsByDay = bills
            .Where(b => b.DueDate.Year == year && b.DueDate.Month == month)
            .GroupBy(b => b.DueDate.Day)
            .ToDictionary(g => g.Key, g => g.Count());

        for (int d = 1; d <= daysInMonth; d++)
        {
            var date = new DateTime(year, month, d);
            cells.Add(new DayCell
            {
                Day = d,
                Date = date,
                IsBlank = false,
                IsToday = date.Date == DateTime.Today,
                BillCount = countsByDay.ContainsKey(d) ? countsByDay[d] : 0
            });
        }

        return cells;
    }
}
