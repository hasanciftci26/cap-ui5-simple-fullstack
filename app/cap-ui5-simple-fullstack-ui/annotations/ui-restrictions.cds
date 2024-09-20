using {OnlineShopping as service} from '../../../srv/data-provider';

annotate service.Products with @Capabilities: {FilterRestrictions: {
    $Type                       : 'Capabilities.FilterRestrictionsType',
    FilterExpressionRestrictions: [{
        $Type             : 'Capabilities.FilterExpressionRestrictionType',
        Property          : isActive,
        AllowedExpressions: 'SingleValue'
    }]
}};
