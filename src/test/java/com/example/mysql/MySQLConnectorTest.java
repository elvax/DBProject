package com.example.mysql;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import static junit.framework.TestCase.assertEquals;
import static junit.framework.TestCase.assertNotNull;

public class MySQLConnectorTest {
    MySQLConnector mySQLConnector;

    @Before
    public void initialize() throws Exception {
        mySQLConnector = new MySQLConnector();
        mySQLConnector.prepareEverything();
    }

    @Test
    public void loginStudentTest() {
        String userName = "nowak1";
        String hashPassword = "FB2FE71D592FAD516F05549409DA8E35";

        String result = mySQLConnector.loginStudent(userName, hashPassword);

        assertEquals("1", result);
    }

    @After
    public void close() {
        mySQLConnector.close();
    }
}
