#ifndef PUPIL_DETECT_H
#define PUPIL_DETECT_H
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/imgproc/imgproc.hpp>
#include <iostream>
#include <opencv/cv.hpp>
#include <opencv/cxcore.hpp>


int biPupilDetect(cv::Mat eyeL,
                cv::Rect roiL,
                cv::Point pupilCenterL,
                cv::Mat eyeR ,
                cv::Rect roiR,
                 cv::Point pupilCenterR,
                cv::Mat obj,
                float &objScale);


int monoPupilDetect(cv::Mat eye,
                cv::Rect roi,
                cv::Point pupilCenter,
                cv::Mat obj,
                float &objScale);



#endif // PUPIL_DETECT_H
