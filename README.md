# 📚 City145 Library Loan System Automation

This project automates the City-145 Library's loan system using MySQL, implementing borrowing rules, fine calculations, and membership management.

---

## 📁 Project Structure

### 🗂 Entities and Relationships
- **Strong Entities**: `Author`, `Publisher`, `Branch`, `Member`, `Book`  
  Each entity is uniquely identified by its primary keys: `AuthorID`, `PublisherID`, `BranchID`, `MemberID`, `BookID`.
  
- **Weak Entities**: `Authoredby`, `Holding`, `BorrowedBy`  
  - `Authoredby` depends on `BookID` and `AuthorID`.
  - `Holding` depends on `BranchID` and `BookID`.
  - `BorrowedBy` depends on `BranchID`, `BookID`, `MemberID`.
  
- **Associative Tables**: `Authoredby`, `Holding`, `BorrowedBy`  
  These tables resolve many-to-many relationships between members, branches, books, and authors.

### 📏 Business Rules

The database enforces these borrowing rules:
1. ✅ **Book Availability**: Books can only be borrowed if available at the branch.
2. 👤 **Membership Status**: Only "REGULAR" members can borrow.
3. 📅 **Borrowing Limit**: Up to 5 items for 21 days.
4. 📅 **Return Dates**: Must be within membership expiry.
5. ⚠️ **Fee Suspension**: Membership is suspended if fees reach $30.
6. ⏳ **Overdue Fines**: $2/day for overdue items; membership suspended until resolved.
7. 🔄 **Status Reset**: Clears membership suspension after fine resolution.

---

## 📊 Database Structure

This project includes:
- **Tables**: `Author`, `Publisher`, `Branch`, `Member`, `Book`, `Authoredby`, `Holding`, `BorrowedBy`
- **Constraints**: Primary keys for strong entities, foreign keys for weak entities, and unique constraints on borrowing rules

---

## 🛠 Setup

1. **Clone the repository**:
   ```bash
   git clone https://github.com/GinaPhan/Library_LoanSystem.git
   ```

2. **Import** the database schema and data into MySQL.

3. **Test** database functionality for loan management, fine calculations, and membership updates.

---

## 💻 Usage

This database system supports library staff by allowing them to:
- 📄 **Register** new books, authors, publishers, branches.
- 📊 **Track** book availability and loan status.
- 💸 **Calculate and apply** overdue fees.
- 🔄 **Manage** member status based on fees and overdue items.

---

## 🚀 Future Enhancements

- **📈 Reports**: Summarize borrowing trends, fine history, and member activity.
- **🌐 User Interface**: Develop a user-friendly interface for library staff and member access.
