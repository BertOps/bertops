export model="bert-base-uncased"
export output_dir="bertops"

python -m torch.distributed.launch \
        --nproc_per_node 4 run_mlm.py \
        --model_name_or_path $model \
        --train_file ../data/pretrain/train.txt \
        --per_device_train_batch_size 64 \
        --num_train_epochs 10 \
        --do_train \
        --output_dir $output_dir \
        --max_seq_length 512 \
        --cache_dir $output_dir/cache \
        --save_strategy steps \
        --save_steps 5000 \
        --save_total_limit 100 \
        --logging_strategy steps \
        --logging_steps 1000 \
        --line_by_line \
        --report_to none \
        --ddp_find_unused_parameters False \
        --evaluation_strategy no \
        --eval_accumulation_steps 256 \
        --dataloader_num_workers 4 \
        --resume_from_checkpoint $output_dir/checkpoint-CHECKPOINT ## If continuing pretraining, else remove this line