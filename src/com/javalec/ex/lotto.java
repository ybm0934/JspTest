package com.javalec.ex;

import java.util.Random;

public class lotto {

	public static void main(String[] args) {

		Random ran = new Random();

		final int MAX = 45;

		int[] arr = new int[6];

		for (int i = 0; i < arr.length; i++) {
			arr[i] = (ran.nextInt(MAX)) + 1;
			for (int j = 0; j < i; j++) {
				if (arr[i] == arr[j]) {
					i--;
				}
			}
		}

		for (int i = 0; i < arr.length; i++) {
			for (int j = i + 1; j < arr.length; j++) {
				if (arr[i] > arr[j]) {
					int temp = arr[i];
					arr[i] = arr[j];
					arr[j] = temp;
				}
			}
		}

		for (int value : arr) {
			System.out.print(value + "\t");
		}
	}

}
