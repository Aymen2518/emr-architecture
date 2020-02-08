
[
{
    "Classification": "capacity-scheduler",
    "Properties": {
        "yarn.scheduler.capacity.maximum-am-resource-percent": "0.6",
        "yarn.scheduler.capacity.resource-calculator": "org.apache.hadoop.yarn.util.resource.DominantResourceCalculator",
        "yarn.scheduler.capacity.root.queues": "default,gold,silver, bronze",
        "yarn.scheduler.capacity.root.default.capacity": "10",
        "yarn.scheduler.capacity.root.default.user-limit-factor": "2",
        "yarn.scheduler.capacity.root.default.maximum-capacity": "40",
        "yarn.scheduler.capacity.root.gold.capacity": "40",
        "yarn.scheduler.capacity.root.silver.capacity": "30",
        "yarn.scheduler.capacity.root.bronze.capacity": "20",
        "yarn.scheduler.capacity.root.gold.user-limit-factor": "2",
        "yarn.scheduler.capacity.root.silver.user-limit-factor": "2",
        "yarn.scheduler.capacity.root.bronze.user-limit-factor": "2",
        "yarn.scheduler.capacity.root.gold.maximum-capacity": "70",
        "yarn.scheduler.capacity.root.silver.maximum-capacity": "60",
        "yarn.scheduler.capacity.root.bronze.maximum-capacity": "50",
        "yarn.scheduler.capacity.root.gold.state": "RUNNING",
        "yarn.scheduler.capacity.root.silver.state": "RUNNING",
        "yarn.scheduler.capacity.root.bronze.state": "RUNNING",
        "yarn.scheduler.capacity.root.gold.acl_submit_applications": "*",
        "yarn.scheduler.capacity.root.silver.acl_submit_applications": "*",
        "yarn.scheduler.capacity.root.bronze.acl_submit_applications": "*"
   }
 },
 {
   "Classification": "yarn-site",
   "Properties": {
     "yarn.acl.enable": "true",
     "yarn.resourcemanager.scheduler.class": "org.apache.hadoop.yarn.server.resourcemanager.scheduler.capacity.CapacityScheduler"
   }
 },
 {
   "Classification": "spark",
   "Properties": {
     "maximizeResourceAllocation": "true"
   }
 },
  {
    "classification": "livy-conf",
    "Properties": {
        "livy.server.session.timeout":"3h",
        "livy.server.session.max-creation":"10"
        }
  }
]
