package com.dao;

import com.model.FeePayment;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;

public class FeePaymentDAO {
	private String jdbcURL = "jdbc:mysql://localhost:3306/CollegeFeeDB?useSSL=false&serverTimezone=UTC";
	private String jdbcUsername = "root";  // Your MySQL username
	private String jdbcPassword = "password";  // Your MySQL password
	
    private static final String INSERT_PAYMENT = "INSERT INTO FeePayments (StudentID, StudentName, PaymentDate, Amount, Status) VALUES (?, ?, ?, ?, ?)";
    private static final String UPDATE_PAYMENT = "UPDATE FeePayments SET StudentID=?, StudentName=?, PaymentDate=?, Amount=?, Status=? WHERE PaymentID=?";
    private static final String DELETE_PAYMENT = "DELETE FROM FeePayments WHERE PaymentID=?";
    private static final String SELECT_ALL_PAYMENTS = "SELECT * FROM FeePayments ORDER BY PaymentDate DESC";
    private static final String SELECT_OVERDUE = "SELECT * FROM FeePayments WHERE Status='Overdue'";
    private static final String SELECT_UNPAID_IN_PERIOD = "SELECT * FROM FeePayments WHERE PaymentDate NOT BETWEEN ? AND ?";
    private static final String SELECT_TOTAL_COLLECTION = "SELECT SUM(Amount) as Total FROM FeePayments WHERE PaymentDate BETWEEN ? AND ? AND Status='Paid'";
    
    protected Connection getConnection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        return connection;
    }
    
    // Add Fee Payment
    public boolean addFeePayment(FeePayment payment) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_PAYMENT)) {
            preparedStatement.setInt(1, payment.getStudentId());
            preparedStatement.setString(2, payment.getStudentName());
            preparedStatement.setDate(3, new java.sql.Date(payment.getPaymentDate().getTime()));
            preparedStatement.setBigDecimal(4, payment.getAmount());
            preparedStatement.setString(5, payment.getStatus());
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Update Fee Payment
    public boolean updateFeePayment(FeePayment payment) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_PAYMENT)) {
            preparedStatement.setInt(1, payment.getStudentId());
            preparedStatement.setString(2, payment.getStudentName());
            preparedStatement.setDate(3, new java.sql.Date(payment.getPaymentDate().getTime()));
            preparedStatement.setBigDecimal(4, payment.getAmount());
            preparedStatement.setString(5, payment.getStatus());
            preparedStatement.setInt(6, payment.getPaymentId());
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Delete Fee Payment
    public boolean deleteFeePayment(int paymentId) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_PAYMENT)) {
            preparedStatement.setInt(1, paymentId);
            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    // Get All Payments
    public List<FeePayment> getAllFeePayments() {
        List<FeePayment> payments = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_PAYMENTS)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                payments.add(extractFeePaymentFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }
    
    // Get Overdue Payments
    public List<FeePayment> getOverduePayments() {
        List<FeePayment> payments = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_OVERDUE)) {
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                payments.add(extractFeePaymentFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }
    
    // Get Students Who Haven't Paid in Period
    public List<FeePayment> getUnpaidInPeriod(String startDate, String endDate) {
        List<FeePayment> payments = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_UNPAID_IN_PERIOD)) {
            preparedStatement.setDate(1, java.sql.Date.valueOf(startDate));
            preparedStatement.setDate(2, java.sql.Date.valueOf(endDate));
            ResultSet rs = preparedStatement.executeQuery();
            while (rs.next()) {
                payments.add(extractFeePaymentFromResultSet(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return payments;
    }
    
    // Get Total Collection in Date Range
    public BigDecimal getTotalCollection(String startDate, String endDate) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_TOTAL_COLLECTION)) {
            preparedStatement.setDate(1, java.sql.Date.valueOf(startDate));
            preparedStatement.setDate(2, java.sql.Date.valueOf(endDate));
            ResultSet rs = preparedStatement.executeQuery();
            if (rs.next()) {
                return rs.getBigDecimal("Total") != null ? rs.getBigDecimal("Total") : BigDecimal.ZERO;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return BigDecimal.ZERO;
    }
    
    private FeePayment extractFeePaymentFromResultSet(ResultSet rs) throws SQLException {
        FeePayment payment = new FeePayment();
        payment.setPaymentId(rs.getInt("PaymentID"));
        payment.setStudentId(rs.getInt("StudentID"));
        payment.setStudentName(rs.getString("StudentName"));
        payment.setPaymentDate(rs.getDate("PaymentDate"));
        payment.setAmount(rs.getBigDecimal("Amount"));
        payment.setStatus(rs.getString("Status"));
        return payment;
    }
}