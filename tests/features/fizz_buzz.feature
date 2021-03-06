Feature: I want to get FizzBuzz

  Scenario: FizzBuzz should success with valid parameters
    Given I reset HTTP client

    # --------------------------------------------------------------------------------
    # Reset record requests
    # --------------------------------------------------------------------------------
    And I reset fizzBuzz request stats
    Then response status code should be 200

    When I set request query
      | fizz_modulo | 3   |
      | buzz_modulo | 5   |
      | limit       | 15  |
      | fizz_string | foo |
      | buzz_string | bar |
    And I get fizzBuzz
    Then response status code should be 200
    And json response should resemble
    """
    {
      "result": "1,2,foo,4,bar,foo,7,8,foo,bar,11,foo,13,14,foobar"
    }
    """

  Scenario: FizzBuzz should fail with invalid parameters
    # --------------------------------------------------------------------------------
    # With missing parameters
    # --------------------------------------------------------------------------------
    Given I reset HTTP client
    When I get fizzBuzz
    Then response status code should be 400
    Then json response should resemble
    """
    {
      "details": [
          "missing fizz modulo",
          "missing buzz modulo",
          "missing limit",
          "missing fizz string",
          "missing buzz string"
      ],
      "status": 400
    }
    """

    # --------------------------------------------------------------------------------
    # With invalid parameters
    # --------------------------------------------------------------------------------
    Given I reset HTTP client
    When I set request query
      | fizz_modulo | foo  |
      | buzz_modulo | -15  |
      | limit       | 1001 |
      | fizz_string | foo  |
      | buzz_string | bar  |
    And I get fizzBuzz
    Then json response should resemble
    """
    {
      "details": [
          "missing fizz modulo",
          "invalid buzz modulo",
          "max allowed limit exceed"
      ],
      "status": 400
    }
    """
