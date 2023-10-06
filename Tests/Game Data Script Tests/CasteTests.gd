

extends GdUnitTestSuite

const casteClass = preload("res://Game Data Scripts/Caste.gd")

func test_HandleSelections_empty():
	
	var test = casteClass.new()
	var choices = [0, 0, 0]
	var totalOptions = len(choices)
	var limitednessScore = 0.0
	
	var actual = test.HandleSelections(choices, totalOptions, limitednessScore)
	var expected = 3.0 / totalOptions
	
	assert_float(actual).is_equal(expected)
	
func test_HandleSelections_full():
	
	var test = casteClass.new()
	var choices = [1, 1, 1]
	var totalOptions = len(choices)
	var limitednessScore = 0.0
	
	var actual = test.HandleSelections(choices, totalOptions, limitednessScore)
	var expected = 3.0 / totalOptions
	
	assert_float(actual).is_equal(expected)
	

func test_HandleSelections_partFullOdd():
	
	var test = casteClass.new()
	var choices = [1, 1, 0]
	var totalOptions = len(choices)
	var limitednessScore = 0.0
	
	var actual = test.HandleSelections(choices, totalOptions, limitednessScore)
	var expected = 2.0 / totalOptions
	
	assert_float(actual).is_equal(expected)
	
	
func test_HandleSelections_partFullEven():
	
	var test = casteClass.new()
	var choices = [1, 0, 1, 0]
	var totalOptions = len(choices)
	var limitednessScore = 0.0
	
	var actual = test.HandleSelections(choices, totalOptions, limitednessScore)
	var expected = 2.0 / totalOptions
	
	assert_float(actual).is_equal(expected)
	
	
func test_HandleSelections_veryLarge():
	
	var test = casteClass.new()
	var choices = [1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
	var totalOptions = len(choices)
	var limitednessScore = 0.0
	
	var actual = test.HandleSelections(choices, totalOptions, limitednessScore)
	var expected = 2.0 / totalOptions
	
	assert_float(actual).is_equal(expected)
	
	
func test_HandleSelections_SmallSequence():
	
	var test = casteClass.new()
	var choices = [1, 0, 1, 0, 0, 0, 0, 0, 0, 0, 0]
	var totalOptions = len(choices)
	var limitednessScore = 0.0
	
	var actual = 0
	actual += test.HandleSelections(choices, totalOptions, limitednessScore)
	actual += test.HandleSelections(choices, totalOptions, limitednessScore)
	var expected = (2.0 / totalOptions) * 2
	
	assert_float(actual).is_equal(expected)
	
	
func test_HandleSelections_LargeSequence():
	
	var test = casteClass.new()
	var choices = [1, 0, 1, 0]
	var totalOptions = len(choices)
	var limitednessScore = 0.0
	
	var actual = 0
	actual += test.HandleSelections(choices, totalOptions, limitednessScore)
	actual += test.HandleSelections(choices, totalOptions, limitednessScore)
	actual += test.HandleSelections(choices, totalOptions, limitednessScore)
	actual += test.HandleSelections(choices, totalOptions, limitednessScore)
	var expected = (2.0 / totalOptions) * 4
	
	assert_float(actual).is_equal(expected)
	
	

	
