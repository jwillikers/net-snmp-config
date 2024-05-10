#!/usr/bin/env nu
use std *

# todo Make this a proper pass script.

def smartctl [
    device: string
] {
    let result = (
        do { ^smartctl --attributes --json $device } |
        complete
    )
    if ($result.exit_code == 0) {
        $result.stdout | from json
    } else {
        log warning $result.stderr
        null
    }
}

# Experimental MIB
let root_oid = ".1.3.6.1.3.2"

# ATA -A
# {
#   "json_format_version": [
#     1,
#     0
#   ],
#   "smartctl": {
#     "version": [
#       7,
#       4
#     ],
#     "pre_release": false,
#     "svn_revision": "5530",
#     "platform_info": "x86_64-linux-6.6.9-200.fc39.x86_64",
#     "build_info": "(local build)",
#     "argv": [
#       "smartctl",
#       "-a",
#       "-A",
#       "--json",
#       "/dev/sda1"
#     ],
#     "drive_database_version": {
#       "string": "7.3/5528"
#     },
#     "exit_status": 0
#   },
#   "local_time": {
#     "time_t": 1705271140,
#     "asctime": "Sun Jan 14 16:25:40 2024 CST"
#   },
#   "device": {
#     "name": "/dev/sda1",
#     "info_name": "/dev/sda1 [SAT]",
#     "type": "sat",
#     "protocol": "ATA"
#   },
#   "model_family": "Silicon Motion based SSDs",
#   "model_name": "TS512GMTS430S",
#   "serial_number": "H521180387",
#   "wwn": {
#     "naa": 5,
#     "oui": 8140104,
#     "id": 8521180387
#   },
#   "firmware_version": "22Z3V4EI",
#   "user_capacity": {
#     "blocks": 1000215216,
#     "bytes": 512110190592
#   },
#   "logical_block_size": 512,
#   "physical_block_size": 512,
#   "rotation_rate": 0,
#   "form_factor": {
#     "ata_value": 7,
#     "name": "M.2"
#   },
#   "trim": {
#     "supported": true,
#     "deterministic": true,
#     "zeroed": true
#   },
#   "in_smartctl_database": true,
#   "ata_version": {
#     "string": "ACS-3 T13/2161-D revision 5",
#     "major_value": 2032,
#     "minor_value": 109
#   },
#   "sata_version": {
#     "string": "SATA 3.3",
#     "value": 511
#   },
#   "interface_speed": {
#     "max": {
#       "sata_value": 14,
#       "string": "6.0 Gb/s",
#       "units_per_second": 60,
#       "bits_per_unit": 100000000
#     },
#     "current": {
#       "sata_value": 3,
#       "string": "6.0 Gb/s",
#       "units_per_second": 60,
#       "bits_per_unit": 100000000
#     }
#   },
#   "smart_support": {
#     "available": true,
#     "enabled": true
#   },
#   "smart_status": {
#     "passed": true
#   },
#   "ata_smart_data": {
#     "offline_data_collection": {
#       "status": {
#         "value": 0,
#         "string": "was never started"
#       },
#       "completion_seconds": 0
#     },
#     "self_test": {
#       "status": {
#         "value": 0,
#         "string": "completed without error",
#         "passed": true
#       },
#       "polling_minutes": {
#         "short": 2,
#         "extended": 30,
#         "conveyance": 2
#       }
#     },
#     "capabilities": {
#       "values": [
#         123,
#         2
#       ],
#       "exec_offline_immediate_supported": true,
#       "offline_is_aborted_upon_new_cmd": false,
#       "offline_surface_scan_supported": true,
#       "self_tests_supported": true,
#       "conveyance_self_test_supported": true,
#       "selective_self_test_supported": true,
#       "attribute_autosave_enabled": false,
#       "error_logging_supported": true,
#       "gp_logging_supported": true
#     }
#   },
#   "ata_smart_attributes": {
#     "revision": 16,
#     "table": [
#       {
#         "id": 1,
#         "name": "Raw_Read_Error_Rate",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 0,
#           "string": "0"
#         }
#       },
#       {
#         "id": 5,
#         "name": "Reallocated_Sector_Ct",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 0,
#           "string": "0"
#         }
#       },
#       {
#         "id": 9,
#         "name": "Power_On_Hours",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 786,
#           "string": "786"
#         }
#       },
#       {
#         "id": 12,
#         "name": "Power_Cycle_Count",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 45,
#           "string": "45"
#         }
#       },
#       {
#         "id": 148,
#         "name": "Total_SLC_Erase_Ct",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 7805,
#           "string": "7805"
#         }
#       },
#       {
#         "id": 149,
#         "name": "Max_SLC_Erase_Ct",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 132,
#           "string": "132"
#         }
#       },
#       {
#         "id": 150,
#         "name": "Min_SLC_Erase_Ct",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 0,
#           "string": "0"
#         }
#       },
#       {
#         "id": 151,
#         "name": "Average_SLC_Erase_Ct",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 54,
#           "string": "54"
#         }
#       },
#       {
#         "id": 159,
#         "name": "DRAM_1_Bit_Error_Count",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 0,
#           "string": "0"
#         }
#       },
#       {
#         "id": 160,
#         "name": "Uncorrectable_Error_Cnt",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 0,
#           "string": "0"
#         }
#       },
#       {
#         "id": 161,
#         "name": "Valid_Spare_Block_Cnt",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 139,
#           "string": "139"
#         }
#       },
#       {
#         "id": 163,
#         "name": "Initial_Bad_Block_Count",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 17,
#           "string": "17"
#         }
#       },
#       {
#         "id": 164,
#         "name": "Total_Erase_Count",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 66154,
#           "string": "66154"
#         }
#       },
#       {
#         "id": 165,
#         "name": "Max_Erase_Count",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 30,
#           "string": "30"
#         }
#       },
#       {
#         "id": 166,
#         "name": "Min_Erase_Count",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 1,
#           "string": "1"
#         }
#       },
#       {
#         "id": 167,
#         "name": "Average_Erase_Count",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 21,
#           "string": "21"
#         }
#       },
#       {
#         "id": 168,
#         "name": "Max_Erase_Count_of_Spec",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 3000,
#           "string": "3000"
#         }
#       },
#       {
#         "id": 169,
#         "name": "Remaining_Lifetime_Perc",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 100,
#           "string": "100"
#         }
#       },
#       {
#         "id": 177,
#         "name": "Wear_Leveling_Count",
#         "value": 100,
#         "worst": 100,
#         "thresh": 50,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 0,
#           "string": "0"
#         }
#       },
#       {
#         "id": 181,
#         "name": "Program_Fail_Cnt_Total",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 0,
#           "string": "0"
#         }
#       },
#       {
#         "id": 182,
#         "name": "Erase_Fail_Count_Total",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 0,
#           "string": "0"
#         }
#       },
#       {
#         "id": 192,
#         "name": "Power-Off_Retract_Count",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 7,
#           "string": "7"
#         }
#       },
#       {
#         "id": 194,
#         "name": "Temperature_Celsius",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 36,
#           "string": "36"
#         }
#       },
#       {
#         "id": 195,
#         "name": "Hardware_ECC_Recovered",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 0,
#           "string": "0"
#         }
#       },
#       {
#         "id": 196,
#         "name": "Reallocated_Event_Count",
#         "value": 100,
#         "worst": 100,
#         "thresh": 16,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 0,
#           "string": "0"
#         }
#       },
#       {
#         "id": 199,
#         "name": "UDMA_CRC_Error_Count",
#         "value": 100,
#         "worst": 100,
#         "thresh": 50,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 0,
#           "string": "0"
#         }
#       },
#       {
#         "id": 232,
#         "name": "Available_Reservd_Space",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 100,
#           "string": "100"
#         }
#       },
#       {
#         "id": 241,
#         "name": "Host_Writes_32MiB",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 108044,
#           "string": "108044"
#         }
#       },
#       {
#         "id": 242,
#         "name": "Host_Reads_32MiB",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 12857,
#           "string": "12857"
#         }
#       },
#       {
#         "id": 245,
#         "name": "TLC_Writes_32MiB",
#         "value": 100,
#         "worst": 100,
#         "thresh": 0,
#         "when_failed": "",
#         "flags": {
#           "value": 0,
#           "string": "------ ",
#           "prefailure": false,
#           "updated_online": false,
#           "performance": false,
#           "error_rate": false,
#           "event_count": false,
#           "auto_keep": false
#         },
#         "raw": {
#           "value": 347308,
#           "string": "347308"
#         }
#       }
#     ]
#   },
#   "power_on_time": {
#     "hours": 786
#   },
#   "power_cycle_count": 45,
#   "temperature": {
#     "current": 36
#   },
#   "ata_smart_error_log": {
#     "summary": {
#       "revision": 1,
#       "count": 0
#     }
#   },
#   "ata_smart_self_test_log": {
#     "standard": {
#       "revision": 1,
#       "count": 0
#     }
#   },
#   "ata_smart_selective_self_test_log": {
#     "revision": 1,
#     "table": [
#       {
#         "lba_min": 0,
#         "lba_max": 0,
#         "status": {
#           "value": 0,
#           "string": "Not_testing"
#         }
#       },
#       {
#         "lba_min": 0,
#         "lba_max": 0,
#         "status": {
#           "value": 0,
#           "string": "Not_testing"
#         }
#       },
#       {
#         "lba_min": 0,
#         "lba_max": 0,
#         "status": {
#           "value": 0,
#           "string": "Not_testing"
#         }
#       },
#       {
#         "lba_min": 0,
#         "lba_max": 0,
#         "status": {
#           "value": 0,
#           "string": "Not_testing"
#         }
#       },
#       {
#         "lba_min": 0,
#         "lba_max": 0,
#         "status": {
#           "value": 0,
#           "string": "Completed",
#           "remaining_percent": 0
#         },
#         "current_lba_min": 0,
#         "current_lba_max": 65535
#       }
#     ],
#     "flags": {
#       "value": 0,
#       "remainder_scan_enabled": false
#     },
#     "power_up_scan_resume_minutes": 0
#   }
# }

# NVMe
# "json_format_version": [
#     1,
#     0
#   ],
#   "smartctl": {
#     "version": [
#       7,
#       4
#     ],
#     "pre_release": false,
#     "svn_revision": "5530",
#     "platform_info": "x86_64-linux-6.6.9-200.fc39.x86_64",
#     "build_info": "(local build)",
#     "argv": [
#       "smartctl",
#       "-a",
#       "-A",
#       "--json",
#       "/dev/nvme0n1"
#     ],
#     "messages": [
#       {
#         "string": "Read Self-test Log failed: Invalid Field in Command (0x002)",
#         "severity": "error"
#       }
#     ],
#     "exit_status": 4
#   },
#   "local_time": {
#     "time_t": 1705271096,
#     "asctime": "Sun Jan 14 16:24:56 2024 CST"
#   },
#   "device": {
#     "name": "/dev/nvme0n1",
#     "info_name": "/dev/nvme0n1",
#     "type": "nvme",
#     "protocol": "NVMe"
#   },
#   "model_name": "Samsung SSD 980 PRO 1TB",
#   "serial_number": "S5P2NG0R751651F",
#   "firmware_version": "3B2QGXA7",
#   "nvme_pci_vendor": {
#     "id": 5197,
#     "subsystem_id": 5197
#   },
#   "nvme_ieee_oui_identifier": 9528,
#   "nvme_total_capacity": 1000204886016,
#   "nvme_unallocated_capacity": 0,
#   "nvme_controller_id": 6,
#   "nvme_version": {
#     "string": "1.3",
#     "value": 66304
#   },
#   "nvme_number_of_namespaces": 1,
#   "nvme_namespaces": [
#     {
#       "id": 1,
#       "size": {
#         "blocks": 1953525168,
#         "bytes": 1000204886016
#       },
#       "capacity": {
#         "blocks": 1953525168,
#         "bytes": 1000204886016
#       },
#       "utilization": {
#         "blocks": 138370824,
#         "bytes": 70845861888
#       },
#       "formatted_lba_size": 512,
#       "eui64": {
#         "oui": 9528,
#         "ext_id": 786269587978
#       }
#     }
#   ],
#   "user_capacity": {
#     "blocks": 1953525168,
#     "bytes": 1000204886016
#   },
#   "logical_block_size": 512,
#   "smart_support": {
#     "available": true,
#     "enabled": true
#   },
#   "smart_status": {
#     "passed": true,
#     "nvme": {
#       "value": 0
#     }
#   },
#   "nvme_smart_health_information_log": {
#     "critical_warning": 0,
#     "temperature": 32,
#     "available_spare": 73,
#     "available_spare_threshold": 10,
#     "percentage_used": 30,
#     "data_units_read": 6728990,
#     "data_units_written": 396270860,
#     "host_reads": 73368720,
#     "host_writes": 12439679812,
#     "controller_busy_time": 147884,
#     "power_cycles": 511,
#     "power_on_hours": 4074,
#     "unsafe_shutdowns": 100,
#     "media_errors": 0,
#     "num_err_log_entries": 0,
#     "warning_temp_time": 0,
#     "critical_comp_time": 0,
#     "temperature_sensors": [
#       32,
#       32
#     ]
#   },
#   "temperature": {
#     "current": 32
#   },
#   "power_cycle_count": 511,
#   "power_on_time": {
#     "hours": 4074
#   },
#   "nvme_error_information_log": {
#     "size": 64,
#     "read": 16,
#     "unread": 0
#   }

def pass [
    oid: string
    --set(-s)
    --get(-g)
    --getnext(-n)
] {
    if [$set $getnext $get] | reduce {|it, acc| return if $acc + $it {}
    {
        print "Only one command may be specified at a time"
        exit 1
    }

    if $set != null {
        log error "not writeable" 
    } else if $getnext != null {

    } else if $get != null {
        if $oid in [$root_oid] {

        }
    } else {
        log error "missing command"
        exit 1
    }

}

def main [
    device: string
    --attribute: string
] {
    if $attribute == null {
        smartctl $device
    } else {
        smartctl $device |
        get nvme_smart_health_information_log |
        get $attribute
    }
}
