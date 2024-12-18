using CatalogService as service from '../../srv/CatalogService';


annotate service.POs with @(

   UI.SelectionFields      : [
      PO_ID,
      PARTNER_GUID.COMPANY_NAME,
      PARTNER_GUID.ADDRESS_GUID.COUNTRY,
      GROSS_AMOUNT
   ],
    //line item
   UI.LineItem             : [
      {
         $Type: 'UI.DataField',
         Value: PO_ID,
      },
      {
         $Type: 'UI.DataField',
         Value: PARTNER_GUID.COMPANY_NAME,
      },
      {
         $Type: 'UI.DataField',
         Value: PARTNER_GUID.ADDRESS_GUID.COUNTRY,
      },
        {
         $Type: 'UI.DataField',
         Value: GROSS_AMOUNT,
      },
      {
         $Type : 'UI.DataFieldForAction',
         Action: 'CatalogService.boost',
         Label : 'boost',
         Inline: true,
      },

       {
         $Type      : 'UI.DataField',
         Value      : OverallStatus,
         Criticality: colorCoding,
      }
      ],
       //annotation header and navigation to object page
   UI.HeaderInfo           : {
      TypeName      : 'Purchase Order',
      TypeNamePlural: 'Purchase Orders',
      // ndetails of navigation page   below is object page heading
      Title         : {
         $Type: 'UI.DataField',
         Value: PO_ID,
      },
      Description   : {
         $Type: 'UI.DataField',
         Value: PARTNER_GUID.COMPANY_NAME,
      },
   },

   //definig the columns in object page
   UI.Facets               : [
      {
         $Type : 'UI.CollectionFacet',
         Label : 'More Info',



       Facets: [
            {
               $Type : 'UI.ReferenceFacet',
               Label : 'Additional data',
               Target: '@UI.Identification',
            },
            {
               $Type : 'UI.ReferenceFacet',
               Label : 'Pricing data',
               Target: '@UI.FieldGroup#Spiderman',
            },
            {
               $Type : 'UI.ReferenceFacet',
               Label : 'Statues',
               Target: '@UI.FieldGroup#Superman',
            },

         ],
    },

      {
         $Type : 'UI.ReferenceFacet',
         Target: 'Items/@UI.LineItem',
      },
   ],


      UI.Identification       : [
      {
         $Type: 'UI.DataField',
         Value: PO_ID,
      },
      {
         $Type: 'UI.DataField',
         Value: PARTNER_GUID_NODE_KEY,
      },
       {
         $Type: 'UI.DataField',
         Value: OVERALL_STATUS,
      },


   ],

      UI.FieldGroup #Spiderman: {
      Label: 'Price Data',
      Data : [
         {
            $Type: 'UI.DataField',
            Value: GROSS_AMOUNT,
         },
         {
            $Type: 'UI.DataField',
            Value: NET_AMOUNT,
         },
         {
            $Type: 'UI.DataField',
            Value: TAX_AMOUNT,
         },
      ],
   },
   UI.FieldGroup #Superman : {
      Label: 'Status',
      Data : [
         {
            $Type: 'UI.DataField',
            Value: CURRENCY_code,
         },

         {
            $Type: 'UI.DataField',
            Value: OVERALL_STATUS,
         },

         {
            $Type: 'UI.DataField',
            Value: LIFECYCLE_STATUS,
         },
   

      ],
      }
   
   
   
   
   
   );