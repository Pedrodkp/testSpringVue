CREATE TABLE LANGUAGES(
    ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    CODE VARCHAR2(50) NOT NULL,
    DESCRIPTION VARCHAR2(50) NOT NULL,
    PRIMARY KEY(id)
);

DELETE FROM LANGUAGES;

INSERT INTO LANGUAGES (ID, CODE, DESCRIPTION)
     VALUES (1, 'BR','Português');
INSERT INTO LANGUAGES (ID, CODE, DESCRIPTION)
     VALUES (2, 'EN','Inglês');
INSERT INTO LANGUAGES (ID, CODE, DESCRIPTION)
     VALUES (3, 'SP','Espanhol');
    
COMMIT;

CREATE TABLE USERS(
    ID NUMBER GENERATED BY DEFAULT AS IDENTITY,
    NAME VARCHAR2(500) NOT NULL,
    BIRTHDAY DATE NOT NULL,
    LANGUAGE_ID NUMBER,
    PRIMARY KEY(id),
    CONSTRAINT FK_USERS_LANGUAGES FOREIGN KEY (LANGUAGE_ID) REFERENCES LANGUAGES (ID)
);

CREATE OR REPLACE VIEW VW_USERS AS
SELECT USERS.ID
     , USERS.NAME
     , USERS.BIRTHDAY
     , LANGUAGES.CODE AS LANGUAGE_CODE
     , LANGUAGES.DESCRIPTION AS LANGUAGE_DESCRIPTION
  FROM USERS 
  LEFT JOIN LANGUAGES ON USERS.LANGUAGE_ID = LANGUAGES.ID;
  
CREATE OR REPLACE TRIGGER TRG_VW_USERS
INSTEAD OF INSERT OR DELETE OR UPDATE
ON VW_USERS
FOR EACH ROW
DECLARE V_LANGUAGE_ID NUMBER;
BEGIN 
    IF INSERTING OR UPDATING THEN
        BEGIN
            SELECT LANGUAGES.ID
              INTO V_LANGUAGE_ID
              FROM LANGUAGES
             WHERE LANGUAGES.CODE = :NEW.LANGUAGE_CODE;
        EXCEPTION
	        WHEN NO_DATA_FOUND THEN
    	        V_LANGUAGE_ID := NULL;
        END;
    END IF;

    IF INSERTING THEN 
        INSERT INTO USERS (NAME, BIRTHDAY, LANGUAGE_ID)
             VALUES (:NEW.NAME, :NEW.BIRTHDAY, V_LANGUAGE_ID);
    ELSIF UPDATING THEN
          UPDATE USERS
             SET NAME = :NEW.NAME
               , BIRTHDAY = :NEW.BIRTHDAY
               , LANGUAGE_ID = V_LANGUAGE_ID
           WHERE ID = :NEW.ID;
    ELSIF DELETING THEN 
          DELETE FROM USERS
           WHERE ID = :OLD.ID;
    END IF;
END TRG_VW_USERS;

ALTER TRIGGER TRG_VW_USERS COMPILE;

COMMIT;
DELETE FROM USERS;
SELECT * FROM USERS;
SELECT * FROM VW_USERS;

INSERT INTO VW_USERS (NAME, BIRTHDAY, LANGUAGE_CODE) 
     VALUES ('Pedro', SYSDATE, 'ES');