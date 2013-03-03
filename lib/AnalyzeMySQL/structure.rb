require 'AnalyzeMySQL/structure/schema'
require 'AnalyzeMySQL/structure/table'
require 'AnalyzeMySQL/structure/column'

module AnalyzeMySQL
  module Structure
    module Sizes
      COL_TYPES = {
          :tinyint => {
              :pattern => /^tinyint/i,
              :unsigned => 255,
              :signed_lo => -128,
              :signed_hi => 127,
              :sized => false,
              :max => false
          },
          :smallint => {
              :pattern => /^smallint/i,
              :unsigned => 65_535,
              :signed_lo => -32_768,
              :signed_hi => 32_767,
              :sized => false,
              :max => false
          },
          :mediumint => {
              :pattern => /^mediumint/i,
              :unsigned => 16_777_215,
              :signed_lo => -8_388_608,
              :signed_hi => 8_388_607,
              :sized => false,
              :max => false
          },
          :int => {
              :pattern => /^int/i,
              :unsigned => 4_294_967_295,
              :signed_lo => -2_147_483_648,
              :signed_hi => 2_147_483_647,
              :sized => false,
              :max => false
          },
          :bigint => {
              :pattern => /^bigint/i,
              :unsigned => 18_446_744_073_709_551_615,
              :signed_lo => -9_223_372_036_854_775_808,
              :signed_hi => 9_223_372_036_854_775_807,
              :sized => false,
              :max => false
          },

          :char => {
              :pattern => /^char\((\d+)\)/i,
              :sized => true,
              :max => false
          },

          :varchar => {
              :pattern => /^varchar\((\d+)\)/i,
              :sized => true,
              :max => false
          },

          :tinytext => {
              :pattern => /^tinytext$/i,
              :max => 255,
              :sized => false
          },

          :mediumtext => {
              :pattern => /^mediumtext$/i,
              :max => 16_777_215,
              :sized => false
          },

          :text => {
              :pattern => /^text$/i,
              :max => 4_294_967_295,
              :sized => false
          }
      }

      COL_ATTRS = {
          :zerofill => {
              :pattern => /zerofill/i
          },

          :unsigned => {
              :pattern => /unsigned/i
          }
      }
    end
  end
end