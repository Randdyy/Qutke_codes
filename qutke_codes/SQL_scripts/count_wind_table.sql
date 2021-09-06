
-- 查询wind表数据量count
select 'AShareCalendar' as table_name,count(*) from wind.AShareCalendar
union all
select 'AShareDescription' as table_name,count(*) from wind.AShareDescription
union all
select 'AShareEODPrices' as table_name,count(*) from wind.AShareEODPrices
union all
select 'AShareEODDerivativeIndicator' as table_name,count(*) from wind.AShareEODDerivativeIndicator
union all
select  'AShareBalanceSheet;' as table_name,count(*)  from wind.AShareBalanceSheet
union all
select 'AShareIncome' as table_name,count(*) from wind.AShareIncome
union all
select 'AShareCashFlow' as table_name,count(*) from wind.AShareCashFlow
union all
select 'AShareFinancialIndicator' as table_name,count(*) from wind.AShareFinancialIndicator
union all
select 'AIndexDescription' as table_name,count(*) from wind.AIndexDescription
union all
select 'AIndexEODPrices' as table_name,count(*) from wind.AIndexEODPrices
union all
select 'AShareTTMHis' as table_name,count(*) from wind.AShareTTMHis
union all
select 'AShareIndustriesCode' as table_name,count(*) from wind.AShareIndustriesCode
union all
select  'AShareSWIndustriesClass' as table_name,count(*) from wind.AShareSWIndustriesClass
union all
select 'AIndexHS300Weight' as table_name,count(*) from wind.AIndexHS300Weight
union all
select 'AShareConseption' as table_name,count(*) from wind.AShareConseption
union all
select 'AIndexCSI500Weight' as table_name,count(*) from wind.AIndexCSI500Weight
union all
select 'CFuturesDescription' as table_name,count(*) from wind.CFuturesDescription
union all
select 'CFuturesContPro' as table_name,count(*) from wind.CFuturesContPro
union all
select 'Cfuturesmarginratio' as table_name,count(*) from wind.Cfuturesmarginratio
union all
select 'HS300IEODPrices' as table_name,count(*) from wind.HS300IEODPrices
union all
select 'HKEXCalendar' as table_name,count(*) from wind.HKEXCalendar
union all
select 'HKShareDescription' as table_name,count(*) from wind.HKShareDescription
union all
select 'HKBalanceSheetSimple' as table_name,count(*) from wind.HKBalanceSheetSimple
union all
select 'HKIncomeSimple' as table_name,count(*) from wind.HKIncomeSimple
union all
select 'HKCashFlowSimple' as table_name,count(*) from wind.HKCashFlowSimple
union all
select 'HKFinancialIndicator' as table_name,count(*) from wind.HKFinancialIndicator
union all
select 'HKStockHSIndustriesMembers' as table_name,count(*) from wind.HKStockHSIndustriesMembers
union all
select 'HKStockIndustriesCode' as table_name,count(*) from wind.HKStockIndustriesCode
union all
select 'HKShareEODDerivativeIndex' as table_name,count(*) from wind.HKShareEODDerivativeIndex
union all
select 'CBondDescription' as table_name,count(*) from wind.CBondDescription
union all
select 'CBondIndustryWind' as table_name,count(*) from wind.CBondIndustryWind
union all
select 'CBondPlateWind' as table_name,count(*) from wind.CBondPlateWind
union all
select 'CBondNegativeCreditEvent' as table_name,count(*) from wind.CBondNegativeCreditEvent
union all
select 'CBondRating' as table_name,count(*) from wind.CBondRating
union all
select 'CBondValuation' as table_name,count(*) from wind.CBondValuation
union all
select 'CBondIssuer' as table_name,count(*) from wind.CBondIssuer
union all
select 'CompIntroduction' as table_name,count(*) from wind.CompIntroduction
union all
select 'HKshareEODPrices' as table_name,count(*) from wind.HKshareEODPrices
union all
select 'AShareTradingSuspension' as table_name,count(*) from wind.AShareTradingSuspension
union all
select 'CfuturesContractMapping' as table_name,count(*) from wind.CfuturesContractMapping
union all
select 'CIndexFuturesEODPrices' as table_name,count(*) from wind.CIndexFuturesEODPrices
union all
select 'CBondFuturesEODPrices' as table_name,count(*) from wind.CBondFuturesEODPrices
union all
select 'CCommodityFuturesEODPrices' as table_name,count(*) from wind.CCommodityFuturesEODPrices
union all
select 'CBondPrices' as table_name,count(*) from wind.CBondPrices
union all
select 'HKStockHSIndexWeight' as table_name,count(*) from wind.HKStockHSIndexWeight
union all
select 'HKIndexDescription' as table_name,count(*) from wind.HKIndexDescription
union all
select 'HKIndexEODPrices' as table_name,count(*) from wind.HKIndexEODPrices
union all
select 'CBondIssuerRating' as table_name,count(*) from wind.CBondIssuerRating
union all
select 'CBondSpecialConditions' as table_name,count(*) from wind.CBondSpecialConditions
union all
select 'CBondCF' as table_name,count(*) from wind.CBondCF
union all
select 'CBIndexDescription' as table_name,count(*) from wind.CBIndexDescription
union all
select 'CBIndexEODPrices' as table_name,count(*) from wind.CBIndexEODPrices
union all
select 'COptionEmbeddedBondValuation' as table_name,count(*) from wind.COptionEmbeddedBondValuation
union all
select 'ChinaMutualFundNAV' as table_name,count(*) from wind.ChinaMutualFundNAV
union all
select  'ChinaMutualFundDescription' as table_name,count(*) from wind.ChinaMutualFundDescription
union all
select 'ChinaOptionDescription' as table_name,count(*) from wind.ChinaOptionDescription
union all
select  'ChinaOptionValuation' as table_name,count(*) from wind.ChinaOptionValuation
union all
select 'CBondCurveCNBD' as table_name,count(*) from wind.CBondCurveCNBD
union all
select 'CBondAnalysisCNBD' as table_name,count(*) from wind.CBondAnalysisCNBD
union all
select 'CMFFinancialIndicator' as table_name,count(*) from wind.CMFFinancialIndicator
union all
select 'ChinaMutualFundStockPortfolio' as table_name,count(*) from wind.ChinaMutualFundStockPortfolio
union all
select  'CMFOtherPortfolio' as table_name,count(*) from wind.CMFOtherPortfolio
union all
select  'ChinaMutualFundAssetPortfolio' as table_name,count(*) from wind.ChinaMutualFundAssetPortfolio
union all
select 'ChinaMutualFundBondPortfolio' as table_name,count(*) from wind.ChinaMutualFundBondPortfolio
union all
select 'chinamutualfundmanager' as table_name,count(*) from wind.chinamutualfundmanager;