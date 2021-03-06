/**
 * Class Name: ESignLiveDocumentUtilitiesTest.cls
 *
 * This test class tests the ESignLiveDocumentUtitlities class and
 * contains methods to test the various encoding methods in that class
 */

@isTest
public class ESignLiveDocumentUtilitiesTest 
{
    /**
     * Test method for encodeDocuments()
     */
    public static testmethod void testEncodeDocuments()
    {
        // Set parameters
        Map<String,Blob> documentMap = ESignLiveTestDataUtility.createDocumentMap();
        
        // Call code to test
        Test.startTest();
        List<String> stringList = ESignLiveDocumentUtilities.encodeDocuments(documentMap, 'boundary', 'name');
        Test.stopTest();
        
        // Verify Resulst
        String expectedResult = 'LS1ib3VuZGFyeQpDb250ZW50LURpc3Bvc2l0aW9uOiBmb3JtLWRhdGE7IG5hbWU9Im5hbWUiOyBmaWxlbmFtZT0iRmlyc3QgRG9jIgpDb250ZW50LVR5cGU6IGFwcGxpY2F0aW9uL3BkZiANCg0KZmlyc3RCbG9iICANCg0KLS1ib3VuZGFyeQpDb250ZW50LURpc3Bvc2l0aW9uOiBmb3JtLWRhdGE7IG5hbWU9Im5hbWUiOyBmaWxlbmFtZT0iU2Vjb25kIERvYyIKQ29udGVudC1UeXBlOiBhcHBsaWNhdGlvbi9wZGYNCg0Kc2Vjb25kQmxvYg0K';
        System.assertEquals(expectedResult, stringList.get(0));
    }

    /**
     * Test method for encondeContent()
     */
    public static testmethod void testEncodeContent()
    {   
        // Set parameters
        String encodeString = 'Encoded String';
        
        // Call code to test
        Test.startTest();
        String result = ESignLiveDocumentUtilities.encodeContent(encodeString);
        Test.stopTest();
        
        // Verify result
        System.assertEquals('RW5jb2RlZCBTdHJpbmcNCg0K', result);
    }

    /**
     * Test method for encodeString
     */
    public static testmethod void testEncodeString()
    {
        // Set parameters
        String encodeString = 'Encoded String';
        
        // Call code to test
        Test.startTest();
        String result = ESignLiveDocumentUtilities.encodeString(encodeString);
        Test.stopTest();
        
        // Verify result
        System.assertEquals('RW5jb2RlZCBTdHJpbmcNCg0K', result);
    }

    /**
     * Test method for comparePackageDocumentsAndMap()
     */
    public static testmethod void testComparePackageDocumentsAndMap()
    {
        // Set parameters
        Map<String,Blob> documentMap = ESignLiveTestDataUtility.createDocumentMap();
        ESignLiveAPIObjects.Package_x pkg = ESignLiveTestDataUtility.createPackageX('packId', 'packName', 'consent');
        
        // Call code to test
        Test.startTest();
        String result = ESignLiveValidation.comparePackageDocumentsAndMap(pkg, documentMap);
        Test.stopTest();
        
        // Verify result
        System.assertEquals('success', result);
    }

    /**
     * Negative test method for comparePackageDocumentsAndMapTest()
     */
    public static testmethod void testComparePackageDocumentsAndMap2()
    {
        // Set parameters
        Map<String,Blob> documentMap = ESignLiveTestDataUtility.createDocumentMap();
        documentMap.put('Third document', Blob.valueOf('myBlob3'));
        ESignLiveAPIObjects.Package_x pkg = ESignLiveTestDataUtility.createPackageX('packId', 'packName', 'consent');
        String result = '';
        // Call code to test
        Test.startTest();

        try
        {
            result = ESignLiveValidation.comparePackageDocumentsAndMap(pkg, documentMap);    
        }
        catch(Exception e)
        {
            result = e.getMessage();
        }
        
        Test.stopTest();
        
        // Verify result
        String expectedResult = 'Package should have equal number of documents as in the document Map';
        System.assertEquals(expectedResult, result);
    }
}