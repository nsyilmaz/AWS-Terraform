
resource "aws_wafv2_regex_pattern_set" "sql_pattern" {
    name       = "SqlPattern"
    scope      = "REGIONAL"

    regular_expression {
        regex_string = "('|\")[ ]+[oO][rR][ ]+'*([0-9]|[a-z]|[A-Z])+'*[ ]*(=|!=)[ ]*'*([0-9]|[a-z]|[A-Z])+'*"   # ' or 1=1 pattern
        #regex_string = "'[ ]+[oO][rR][ ]+[0-9]+(=|!=)[0-9]+[;| |/]*" # similar but enriched.
    }

    regular_expression {
        regex_string = "(?i)[ ]+union([ ]|all)+select[ ]+" # union select 1 pattern
    }

    regular_expression {
        regex_string = "(?i)'[ ]+(.*)+order[ ]+by[ ]+(.+)"  # ' order by 1 pattern
    }
}







resource "aws_wafv2_regex_pattern_set" "os_command_pattern" {
    name       = "OsCommandPattern"
    scope      = "REGIONAL"

    regular_expression {
        regex_string = "(;|\\|)[ ]*(\\/.*\\/)*(chown|sudo|chmod|cat|wget|curl|lynx|sh|bash|echo)[ ]+.*(;|\\|)"  # ; sh xxx ;  pattern
    }

    regular_expression {
        regex_string = "(wget|curl|lynx)[ ]+.+\\..+"    # curl google.com   pattern
    }
}





resource "aws_wafv2_regex_pattern_set" "xss_pattern" {
    name       = "XSSPattern"
    scope      = "REGIONAL"

    regular_expression {
        regex_string = "(?i)style[ ]*=[ ]*\"[ ]*(.)+:[ ]*expression"    #  style="x:expression
    }
}




resource "aws_wafv2_regex_pattern_set" "uri_block_pattern" {
    name       = "UriBlockPattern"
    scope      = "REGIONAL"

    regular_expression {
        regex_string = "/\\..*"    #  /.xxx pattern
    }
}




resource "aws_wafv2_web_acl" "test-1" {
    name       = "test-1"
    scope      = "REGIONAL"

    default_action {
        allow {
        }
    }

    visibility_config {
        cloudwatch_metrics_enabled = true
        metric_name                = "test-1"
        sampled_requests_enabled   = true
    }





    
    rule {
        name     = "Test-Rule-1-Sql-Pattern"
        priority = 1

        action {
            block {
            }
        }
        visibility_config {
            cloudwatch_metrics_enabled = true
            metric_name                = "Test-Rule-1-Sql-Pattern"
            sampled_requests_enabled   = true
        }


        statement {
            or_statement {
                statement {
                   regex_pattern_set_reference_statement {
                      arn = aws_wafv2_regex_pattern_set.sql_pattern.arn

                         field_to_match {
                              all_query_arguments {}
                            }


                        text_transformation {
                           priority = 0
                            type     = "URL_DECODE"
                        }
                    }
                }

                statement {
                   regex_pattern_set_reference_statement {
                      arn = aws_wafv2_regex_pattern_set.sql_pattern.arn

                         field_to_match {
                              body {}
                            }


                        text_transformation {
                           priority = 0
                            type     = "URL_DECODE"
                        }
                    }
                }
            }
        }
    }



    rule {
        name     = "Test-Rule-2-Os-Command-Pattern"
        priority = 2

        action {
            block {
            }
        }
        visibility_config {
            cloudwatch_metrics_enabled = true
            metric_name                = "Test-Rule-2-Os-Command-Pattern"
            sampled_requests_enabled   = true
        }



        statement {
            or_statement {
                statement {
                   regex_pattern_set_reference_statement {
                      arn = aws_wafv2_regex_pattern_set.os_command_pattern.arn

                         field_to_match {
                              all_query_arguments {}
                            }


                        text_transformation {
                           priority = 0
                            type     = "URL_DECODE"
                        }
                    }
                }

                statement {
                   regex_pattern_set_reference_statement {
                      arn = aws_wafv2_regex_pattern_set.os_command_pattern.arn

                         field_to_match {
                              body {}
                            }


                        text_transformation {
                           priority = 0
                            type     = "URL_DECODE"
                        }
                    }
                }
            }
        }
    }





    rule {
        name     = "Test-Rule-3-XSS-Pattern"
        priority = 3

        action {
            block {
            }
        }
        visibility_config {
            cloudwatch_metrics_enabled = true
            metric_name                = "Test-Rule-3-XSS-Pattern"
            sampled_requests_enabled   = true
        }



        statement {
            or_statement {
                statement {
                   regex_pattern_set_reference_statement {
                      arn = aws_wafv2_regex_pattern_set.xss_pattern.arn

                         field_to_match {
                              all_query_arguments {}
                            }


                        text_transformation {
                           priority = 0
                            type     = "URL_DECODE"
                        }
                    }
                }

                statement {
                   regex_pattern_set_reference_statement {
                      arn = aws_wafv2_regex_pattern_set.xss_pattern.arn

                         field_to_match {
                              body {}
                            }


                        text_transformation {
                           priority = 0
                            type     = "URL_DECODE"
                        }
                    }
                }
            }
        }
    }



    rule {
        name     = "Test-Rule-3-Uri-Block-Pattern"
        priority = 4

        action {
            block {
            }
        }
        visibility_config {
            cloudwatch_metrics_enabled = true
            metric_name                = "Test-Rule-3-Uri-Block-Pattern"
            sampled_requests_enabled   = true
        }

        statement {

            regex_pattern_set_reference_statement {
                arn = aws_wafv2_regex_pattern_set.uri_block_pattern.arn

                field_to_match {

                    uri_path {}
                }

                text_transformation {
                    priority = 0
                    type     = "URL_DECODE"
                }
            }
        }
    }








    rule {
        name     = "Test-Rule-4-Rate-Limit"
        priority = 5

        action {
            block {}
        }
        visibility_config {
            cloudwatch_metrics_enabled = true
            metric_name                = "Test-Rule-4-Rate-Limit"
            sampled_requests_enabled   = true
        }

        statement {
            rate_based_statement {
                aggregate_key_type = "IP"
                limit              = 101
            }
        }

    }





}






resource "aws_wafv2_web_acl_association" "web_acl_association_my_lb-2" {
  resource_arn = aws_lb.MyLoader.arn
  web_acl_arn  = aws_wafv2_web_acl.test-1.arn
}













