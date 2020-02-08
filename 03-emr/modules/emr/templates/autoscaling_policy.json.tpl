{
    "Rules": [
      {
          "Action": {
              "SimpleScalingPolicyConfiguration": {
                  "CoolDown": 300,
                  "ScalingAdjustment": 3,
                  "AdjustmentType": "CHANGE_IN_CAPACITY"
              }
          },
          "Trigger": {
              "CloudWatchAlarmDefinition": {
                  "EvaluationPeriods": 1,
                  "Namespace": "AWS/ElasticMapReduce",
                  "Period": 300,
                  "ComparisonOperator": "LESS_THAN",
                  "Statistic": "AVERAGE",
                  "Threshold": 15.0,
                  "Unit": "PERCENT",
                  "MetricName": "YARNMemoryAvailablePercentage"
              }
          },
          "Name": "ScaleOutMemoryPercentage",
          "Description": ""
      },
      {
          "Action": {
              "SimpleScalingPolicyConfiguration": {
                  "CoolDown": 300,
                  "ScalingAdjustment": -1,
                  "AdjustmentType": "CHANGE_IN_CAPACITY"
              }
          },
          "Trigger": {
              "CloudWatchAlarmDefinition": {
                  "EvaluationPeriods": 1,
                  "Namespace": "AWS/ElasticMapReduce",
                  "Period": 300,
                  "ComparisonOperator": "GREATER_THAN",
                  "Statistic": "AVERAGE",
                  "Threshold": 75.0,
                  "Unit": "PERCENT",
                  "MetricName": "YARNMemoryAvailablePercentage"
              }
          },
          "Name": "ScaleInMemoryPercentage",
          "Description": ""
      }
    ],
    "Constraints": {
      "MinCapacity": ${min_capacity},
      "MaxCapacity": ${max_capacity}
    }
}