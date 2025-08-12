#!/usr/bin/env python3
"""
🇨🇭 Swiss-precision Routing Engine Test Script
===============================================

This script demonstrates the SwissLife-inspired enterprise file routing system.
Run this to see how the 3-part routing codes work: DEPT-PROCESS-TYPE

Example routing codes:
- FINANCE-PAYMENT-MT940 (Finance dept payment processing with MT940 files)
- HR-PAYROLL-CSV (HR dept payroll processing with CSV files)
- TREASURY-TRADE-CAMT053 (Treasury dept trade processing with CAMT.053 files)
"""

import sys
import os
sys.path.append('./helix-core')

from routing import HelixRoutingEngine, RoutingCode, ProcessingStatus

def demonstrate_routing_engine():
    """Demonstrate the SwissLife-style routing engine"""
    
    print("🇨🇭" + "=" * 68 + "🇨🇭")
    print("     HELIX ENTERPRISE ROUTING ENGINE DEMONSTRATION")
    print("     SwissLife-inspired 3-part routing system")
    print("🇨🇭" + "=" * 68 + "🇨🇭")
    print()
    
    # Initialize the routing engine
    engine = HelixRoutingEngine()
    
    # Display available departments
    print("🏢 AVAILABLE DEPARTMENTS:")
    print("-" * 40)
    for dept_code, dept_info in engine.departments.items():
        print(f"  {dept_info['emoji']} {dept_code}: {dept_info['name']}")
        for process_code, file_types in dept_info['processes'].items():
            print(f"    └─ {process_code}: {', '.join(file_types)}")
    print()
    
    # Test valid routing codes
    print("✅ TESTING VALID ROUTING CODES:")
    print("-" * 40)
    test_codes = [
        ("FINANCE", "PAYMENT", "MT940"),
        ("HR", "PAYROLL", "CSV"),
        ("TREASURY", "TRADE", "CAMT053"),
        ("COMPLIANCE", "AUDIT", "BAI2"),
        ("OPERATIONS", "SETTLEMENT", "PAIN001")
    ]
    
    jobs = []
    for dept, process, file_type in test_codes:
        routing_code = RoutingCode(dept, process, file_type)
        if engine.validate_routing_code(routing_code):
            job = engine.create_file_job(
                routing_code=routing_code,
                file_path=f"test_{file_type.lower()}_file.txt",
                priority="NORMAL",
                notes=f"Demo file for {dept} {process} processing"
            )
            jobs.append(job)
            print(f"  🎯 {routing_code.to_string()}")
            print(f"     └─ Job ID: {job.job_id}")
            print(f"     └─ {engine.get_beautiful_log_message(job, '📤 Created')}")
    print()
    
    # Test invalid routing codes
    print("❌ TESTING INVALID ROUTING CODES:")
    print("-" * 40)
    invalid_codes = [
        ("MARKETING", "PAYMENT", "MT940"),  # Invalid department
        ("FINANCE", "TRADING", "MT940"),    # Invalid process for finance
        ("HR", "PAYROLL", "MT940"),         # Invalid file type for HR payroll
    ]
    
    for dept, process, file_type in invalid_codes:
        routing_code = RoutingCode(dept, process, file_type)
        if not engine.validate_routing_code(routing_code):
            print(f"  ⛔ {routing_code.to_string()} - REJECTED")
            
            # Show why it's invalid
            if dept not in engine.departments:
                print(f"     └─ Department '{dept}' not found")
            elif process not in engine.departments[dept]['processes']:
                print(f"     └─ Process '{process}' not available for {dept}")
            elif file_type not in engine.departments[dept]['processes'][process]:
                print(f"     └─ File type '{file_type}' not supported for {dept}-{process}")
    print()
    
    # Simulate job processing
    print("⚙️ SIMULATING JOB PROCESSING:")
    print("-" * 40)
    for i, job in enumerate(jobs[:3]):  # Process first 3 jobs
        job.start_processing()
        print(f"  {engine.get_beautiful_log_message(job, '🚀 Started')}")
        
        # Simulate completion (in real system, this would be done by file processor)
        if i < 2:  # Complete first 2 jobs
            job.complete_processing()
            print(f"  {engine.get_beautiful_log_message(job, '✅ Completed')}")
        else:  # Fail the 3rd job for demonstration
            job.fail_processing("Demo error: File format validation failed")
            print(f"  {engine.get_beautiful_log_message(job, '❌ Failed')}")
    print()
    
    # Show job statistics
    print("📊 JOB STATISTICS:")
    print("-" * 40)
    total_jobs = len(engine.jobs)
    completed_jobs = len([j for j in engine.jobs.values() if j.status == ProcessingStatus.COMPLETED])
    failed_jobs = len([j for j in engine.jobs.values() if j.status == ProcessingStatus.FAILED])
    pending_jobs = len([j for j in engine.jobs.values() if j.status == ProcessingStatus.PENDING])
    
    print(f"  📈 Total Jobs: {total_jobs}")
    print(f"  ✅ Completed: {completed_jobs}")
    print(f"  ❌ Failed: {failed_jobs}")
    print(f"  ⏳ Pending: {pending_jobs}")
    print()
    
    # Show all routing codes
    print("🎯 ALL VALID ROUTING CODES:")
    print("-" * 40)
    all_codes = []
    for dept_code, dept_info in engine.departments.items():
        for process_code, file_types in dept_info['processes'].items():
            for file_type in file_types:
                routing_code = RoutingCode(dept_code, process_code, file_type)
                all_codes.append(routing_code.to_string())
    
    # Group by department for better readability
    current_dept = None
    for code in sorted(all_codes):
        dept = code.split('-')[0]
        if dept != current_dept:
            if current_dept is not None:
                print()
            dept_info = engine.departments[dept]
            print(f"  {dept_info['emoji']} {dept} ({dept_info['name']}):")
            current_dept = dept
        print(f"    └─ {code}")
    
    print()
    print("🇨🇭" + "=" * 68 + "🇨🇭")
    print("  🎉 SwissLife-inspired routing demonstration complete!")
    print("     Ready to make bankers drool with emoji-rich precision! 🤤")
    print("🇨🇭" + "=" * 68 + "🇨🇭")

if __name__ == "__main__":
    demonstrate_routing_engine()
