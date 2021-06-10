provider "azurerm" {

  features {

   

  }

}

 

resource "azurerm_policy_definition" "Allowedlocationdef" {

  name         = "AllowedLocationdefinition"

  policy_type  = "Custom"

  mode         = "All"

  display_name = "Allowed location North Europe and West Europe"

 

  policy_rule = <<POLICY_RULE

    {

    "if": {

      "not": {

        "field": "location",

        "in": "[parameters('allowedLocations')]"

      }

    },

    "then": {

      "effect": "deny"

    }

  }

POLICY_RULE

 

 

  parameters = <<PARAMETERS

    {

    "allowedLocations": {

      "type": "Array",

      "metadata": {

        "description": "The list of allowed locations for resources.",

        "displayName": "Allowed locations",

        "strongType": "location"

      }

    }

  }

PARAMETERS

 

}

 

 

resource "azurerm_policy_assignment" "Allowedlocationpolicyassignment" {

 name                 = "Allowedlocationpolicyassignment"

  scope                = "/subscriptions/cfde4035-44d8-4bee-a995-eb9199a8a2c1"

  policy_definition_id = azurerm_policy_definition.Allowedlocationdef.id

  description          = "Allowed location North europe and West Europe"

  display_name         = "Allowed Location Policy Assignment"

 

  metadata = <<METADATA

    {

    "category": "General"

    }

METADATA

 

  parameters = <<PARAMETERS

{

  "allowedLocations": {

    "value": [

        "West Europe",

        "North Europe"

         ]

  }

}

PARAMETERS

}
