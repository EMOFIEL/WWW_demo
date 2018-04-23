#setwd("/home/jhavarharshita/PycharmProjects/MxP/demo")
library(rsconnect)
library(ggplot2)
library(shiny)
#rsconnect::setAccountInfo(name='emofiel', token='7883F5BF255F181D72B28B3067DB1C9B', secret='+X1tbh3Ge5BuyWoawGzycDYmr5LbGbfhmzDKRPk4')
#rsconnect::deployApp('/home/jhavarharshita/PycharmProjects/MxP/demo')

rsconnect::setAccountInfo(name='paramitamirza',
                          token='31CE8B7D0870FEDB60CE7393AD984E5C',
                          secret='3dy6mVlsu1LSBLrxPV/WsFiLPaRdByce1T/Vhc2t')
deployApp()
