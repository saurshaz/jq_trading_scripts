#!/bin/sh  
# UNDERLYING_TOKEN 6658305 for BANKNIFTY
_TOKEN="6658305"
_SPOT=34691.5
_FUT_PRICE=34739.30051765591
_TARGET_SPOT=34753.08
_TARGET_DT="2021-08-26T17:47"
_FUT_DT="\"2021-08-26\""

echo "INSTRUMENT TOKEN IS - $_TOKEN"
sudo curl 'https://oxide.sensibull.com/v1/compute/5/builder?enable_per_lot=true&enable_payoff_chart=true&enable_trade_details=false' \
-H 'Content-Type: application/json;charset=UTF-8'    \
--data-binary "{ \
    \"underlying_token\": $_TOKEN , \
    \"current_underlying_price\":$_SPOT, \
    \"atm_iv_per_expiry\":{ \
        \"2021-08-26\":18.445055710313138,\"2021-09-02\":17.49823823965987,\"2021-08-26\":17.911243308871867,\"2021-08-26\":15.391704146252088,\"2021-09-02\":10 \
    }, \
    \"target_underlying_price\":$_TARGET_SPOT, \
    \"target_datetime\":\"$_TARGET_DT:00.000Z\",\
    \"futures_per_expiry\":{$_FUT_DT:$_FUT_PRICE},\
    \"trades\":[\
        {\"instrument_token\":9896194,\"entry_price\":180,\"trade_action\":\"Sell\",\"quantity\":100,\"implied_volatility\":18.1,\"tag\":\"leg:25f17ef1-dbea-4c60-9b66-4dece3f6671q\"},\
        {\"instrument_token\":9889282,\"entry_price\":160,\"trade_action\":\"Sell\",\"quantity\":100,\"implied_volatility\":16.3,\"tag\":\"leg:871eb4a9-b3c2-4b02-b137-aa08c5dd7daq\"},\
        {\"instrument_token\":9882626,\"entry_price\":80,\"trade_action\":\"Buy\",\"quantity\":100,\"implied_volatility\":17.7,\"tag\":\"leg:6a040632-652e-4f5c-b58c-a93516d4f26q\"},\
        {\"instrument_token\":9902850,\"entry_price\":60,\"trade_action\":\"Buy\",\"quantity\":100,\"implied_volatility\":17.2,\"tag\":\"leg:4767ce19-7176-46d0-ae79-d6db2a83baaq\"}\
    ]}" \
--compressed  | jq '.payload | { max_profit: .max_profit, max_loss: .max_loss, breakevens: .breakevens_at_expiry, rr: .risk_reward_ratio, greeks: .greeks, total_premium: .total_premium, projected_payoff: .projected_payoff, decay: .decay, standard_deviation: .standard_deviation, target: .target_datetime, payoff_range: .payoff_range}'
