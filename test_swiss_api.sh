#!/bin/bash
# 🇨🇭 Swiss-Precision API Testing Script
# Test the SwissLife-inspired enterprise routing system

echo "🇨🇭 ====================================================================== 🇨🇭"
echo "     HELIX ENTERPRISE ROUTING ENGINE - SWISS PRECISION TESTING"
echo "     SwissLife-inspired 3-part routing system demonstration"
echo "🇨🇭 ====================================================================== 🇨🇭"
echo

# Step 1: Authenticate and get JWT token
echo "🔐 STEP 1: Getting JWT Authentication Token..."
TOKEN=$(curl -s -X POST "http://localhost:5000/api/auth/login" \
  -H "Content-Type: application/json" \
  -d '{"username": "admin", "password": "adminpass"}' | \
  jq -r '.access_token')

if [ "$TOKEN" != "null" ] && [ -n "$TOKEN" ]; then
    echo "✅ Authentication successful!"
    echo "🎫 Token: ${TOKEN:0:50}..."
else
    echo "❌ Authentication failed!"
    exit 1
fi
echo

# Step 2: Test available departments
echo "🏢 STEP 2: Testing Available Departments..."
curl -s -X GET "http://localhost:5000/api/files/departments" \
  -H "accept: application/json" | jq '.departments[] | "\(.emoji) \(.code): \(.name) - Processes: \(.processes | join(", "))"'
echo

# Step 3: Test a few routing codes
echo "🎯 STEP 3: Testing Sample Routing Codes..."
curl -s -X GET "http://localhost:5000/api/files/routing-codes" \
  -H "accept: application/json" | jq '.routing_codes[:5][] | "✓ \(.routing_code) - \(.description)"'
echo "... and 22 more routing combinations!"
echo

# Step 4: Test file upload simulation (without actual file)
echo "📤 STEP 4: Testing Enterprise File Upload API..."
echo "   Testing FINANCE-PAYMENT-MT940 routing..."

# Create a test file
echo "MT940 Sample Bank Statement
:20:TESTREF123
:25:12345678901/EUR
:28C:1/1
:60F:C230801EUR1000,00
:61:2308010801DR500,00NMSC
:86:Sample debit transaction
:62F:C230801EUR500,00
-" > /tmp/test_mt940.txt

# Test file upload (this will show the API structure even if file upload fails)
echo "   Making API call with Swiss routing precision..."
curl -s -X POST "http://localhost:5000/api/files/upload" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{
    "routing_code": {
      "department": "FINANCE",
      "process": "PAYMENT", 
      "file_type": "MT940"
    },
    "priority": "HIGH",
    "notes": "Swiss precision test upload"
  }' | jq '.'

echo

# Step 5: Test jobs listing
echo "📊 STEP 5: Testing Jobs Management..."
curl -s -X GET "http://localhost:5000/api/files/jobs" \
  -H "Authorization: Bearer $TOKEN" \
  -H "accept: application/json" | jq '.message'
echo

# Step 6: Test dashboard data
echo "📈 STEP 6: Testing Dashboard Integration..."
curl -s -X GET "http://localhost:5000/api/dashboard/stats" \
  -H "accept: application/json" | jq '.'
echo

echo "🇨🇭 ====================================================================== 🇨🇭"
echo "  🎉 Swiss-Precision Testing Complete!"
echo "     Ready to make bankers drool with emoji-rich enterprise routing! 🤤"
echo "🇨🇭 ====================================================================== 🇨🇭"

# Cleanup
rm -f /tmp/test_mt940.txt
